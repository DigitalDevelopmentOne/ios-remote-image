/*
 
 Project: RemoteImage
 File: RemoteImage+MakeUiImageWithProgress+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    public init(url: URL?, @ViewBuilder content: @escaping (UIImage?, Error?, CGFloat) -> Content){
        self.init(url: url, observable: true, option: .uiImageWithProgress(content))
    }
    
    public init(url: String, @ViewBuilder content: @escaping (UIImage?, Error?, CGFloat) -> Content){
        self.init(url: .init(string: url), content: content)
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
}

#if DEBUG
struct RemoteImage_UiImageWithProgress_PreviewView: PreviewProvider {
    static var previews: some View {
        VStack{
            RemoteImage(url: "https://loremflickr.com/400/400") { uiImage, error, progress in
                if let _ = error {
                    Text("Error")
                } else if let uiImage {
                    Image(uiImage: uiImage)
                } else {
                    Text("Downloading: \(progress)")
                }
            }
            .force(true)
            RemoteImage(url: "--") { uiImage, error, progress in
                if let error {
                    Text("Error: \(error.debugDescription)")
                        .font(.system(size: 10))
                } else if let uiImage {
                    Image(uiImage: uiImage)
                } else {
                    Text("Downloading: \(progress)")
                }
            }
            .force(true)
        }
    }
}
#endif
