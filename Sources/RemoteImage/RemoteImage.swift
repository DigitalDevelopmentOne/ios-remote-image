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
    
    
    @StateObject
    var viewModel: ViewModel = .init()
    let url: URL?
    let observable: Bool
    let content: (_ state: State) -> Content
    
    init(url: URL?, observable: Bool, @ViewBuilder content: @escaping (_ state: State) -> Content) {
        self.url = url
        self.observable = observable
        self.content = content
    }
    
    public var body: some View {
        self.content(self.viewModel.state)
            .onAppear{
                self.viewModel.fetchImage(url: self.url, observable: self.observable)
            }
    }
}

#if DEBUG
fileprivate struct PreviewView: View {
    var body: some View {
        ZStack{
            RemoteImage(url: .init(string: "https://loremflickr.com/400/400"), observable: true) { state in
                switch state {
                case .fetch(let progress):
                    Text("\(progress ?? 0)")
                case .inaction:
                    Text("Нету")
                case .success(let image):
                    Image(uiImage: image)
                case .failure(_):
                    Text("Не срослось")
                }
            }
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
