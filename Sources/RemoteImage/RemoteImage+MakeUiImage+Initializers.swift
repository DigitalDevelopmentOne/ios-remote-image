/*
 
 Project: RemoteImage
 File: RemoteImage+MakeUiImage+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    public init(url: URL?, @ViewBuilder content: @escaping (UIImage?, Error?) -> Content){
        self.init(url: url, observable: false, option: .uiImage(content))
    }
    
    public init(url: String, @ViewBuilder content: @escaping (UIImage?, Error?) -> Content){
        self.init(url: .init(string: url), content: content)
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
}

#if DEBUG
struct RemoteImage_UiImage_PreviewView: PreviewProvider {
    static var previews: some View {
        VStack{
            RemoteImage(url: "https://loremflickr.com/400/400") { uiImage, error in
                if let _ = error {
                    Text("Error")
                } else if let uiImage {
                    Image(uiImage: uiImage)
                } else {
                    Text("Downloading")
                }
            }
            .force(true)
            RemoteImage(url: "--") { uiImage, error in
                if let error {
                    Text("Error: \(error.debugDescription)")
                        .font(.system(size: 10))
                } else if let uiImage {
                    Image(uiImage: uiImage)
                } else {
                    Text("Downloading")
                }
            }
            .force(true)
        }
    }
}
#endif
