/*
 
 Project: RemoteImage
 File: RemoteImage.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import SwiftUI

public struct RemoteImage<Content: View>: View, Equatable {
    public static func == (lhs: RemoteImage<Content>, rhs: RemoteImage<Content>) -> Bool {
        lhs.url == rhs.url
    }
    
    enum Option {
        case state((_ state: State) -> Content)
        case uiImage((UIImage?, Error?) -> Content)
        case uiImageWithProgress((UIImage?, Error?, CGFloat) -> Content)
        case image((Image?, Error?) -> Content)
        case imageWithProgress((Image?, Error?, CGFloat) -> Content)
    }
    
    
    @StateObject
    var viewModel: ViewModel = .init()
    let url: URL?
    let observable: Bool
    let option: Self.Option
    var configuration: Configuration?
    var force: Bool
    
    init(
        url: URL?,
        observable: Bool,
        option: Option,
        configuration: Configuration? = nil,
        force: Bool = false) {
            self.url = url
            self.observable = observable
            self.option = option
            self.configuration = configuration
            self.force = force
    }
    
    public func configuration(_ value: Configuration) -> Self {
        var view = self
        view.configuration = configuration
        return view
    }
    
    public func force(_ value: Bool) -> Self {
        var view = self
        view.force = value
        return view
    }
    
    func onAppear(){
        if let configuration {
            self.viewModel.cacheProvider = configuration.cacheProvider.instance()
            self.viewModel.handler = configuration.handler.init()
            self.viewModel.remoteDataProvider = configuration.remoteDataProvider.init()
        }
        self.viewModel.fetchImage(
            url: self.url,
            observable: self.observable,
            force: self.force
        )
    }
    
    @ViewBuilder
    func makeContent() -> some View {
        switch self.option {
        case .state(let content):
            content(self.viewModel.state)
        case .uiImage(let content):
            self.makeUiImage(content: content)
        case .image(let content):
            self.makeImage(content: content)
    
        default:
            Color.red
        }
    }
    
    public init(url: URL?, @ViewBuilder content: @escaping (UIImage?, Error?) -> Content){
        self.init(url: url, observable: false, option: .uiImage(content))
    }
    
    @ViewBuilder
    func makeUiImage(content: (UIImage?, Error?) -> Content) -> some View {
        switch self.viewModel.state {
        case .success(let uiImage):
            content(uiImage, nil)
        case .failure(let error):
            content(nil, error)
        default:
            content(nil, nil)
        }
    }
    
    @ViewBuilder
    func makeUiImageWithProgress(content: (UIImage?, Error?, CGFloat) -> Content) -> some View {
        switch self.viewModel.state {
        case .success(let uiImage):
            content(uiImage, nil, 1)
        case .failure(let error):
            content(nil, error, 0)
        case .fetch(let progress):
            content(nil, nil, progress)
        default:
            content(nil, nil, 0)
        }
    }
    
    @ViewBuilder
    func makeImage(content: (Image?, Error?) -> Content) -> some View {
        switch self.viewModel.state {
        case .success(let uiImage):
            content(Image(uiImage: uiImage), nil)
        case .failure(let error):
            content(nil, error)
        default:
            content(nil, nil)
        }
    }
    
    @ViewBuilder
    func makeImageWithProgress(content: (Image?, Error?, CGFloat) -> Content) -> some View {
        switch self.viewModel.state {
        case .success(let uiImage):
            content(Image(uiImage: uiImage), nil, 1)
        case .failure(let error):
            content(nil, error, 0)
        case .fetch(let progress):
            content(nil, nil, progress)
        default:
            content(nil, nil, 0)
        }
    }
    
    
    public var body: some View {
        self.makeContent()
            .onAppear(perform: self.onAppear)
    }
}


extension RemoteImage {
    public init(url: URL?, @ViewBuilder content: @escaping (State) -> Content){
        self.init(url: url, observable: true, option: .state(content))
    }
}


#if DEBUG
fileprivate struct PreviewView: View {
    var body: some View {
        ZStack{
//            RemoteImage(url: .init(string: "https://loremflickr.com/400/400"), observable: true) { state in
//                switch state {
//                case .fetch(let progress):
//                    Text("\(progress ?? 0)")
//                case .inaction:
//                    Text("Нету")
//                case .success(let image):
//                    Image(uiImage: image)
//                case .failure(_):
//                    Text("Не срослось")
//                }
//            }
            
            RemoteImage(url: .init(string: "https://loremflickr.com/400/400")) { uiImage, error in
                if let _ = error {
                    Text("Error")
                } else if let uiImage {
                    Image(uiImage: uiImage)
                } else {
                    Text("Качаю")
                }
            }
            .force(true)
            //            RemoteImage(url: .init(string: "https://loremflickr.com/400/400"), observable: true) { state in
            //                switch state {
            //                case .fetch(let progress):
            //                    Text("\(progress ?? 0)")
            //                case .inaction:
            //                    Text("Нету")
            //                case .success(let image):
            //                    Image(uiImage: image)
            //                case .failure(_):
            //                    Text("Не срослось")
            //                }
            //            }
        }
        .ignoresSafeArea()
    }
}

struct RemoteImage_PreviewView: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
#endif
