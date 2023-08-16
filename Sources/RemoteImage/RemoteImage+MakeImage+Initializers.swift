/*
 
 Project: RemoteImage
 File: RemoteImage+MakeImage+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    public init(url: URL?, @ViewBuilder content: @escaping (Image?, Error?) -> Content){
        self.init(url: url, observable: false, option: .image(content))
    }
    
    public init(url: String, @ViewBuilder content: @escaping (Image?, Error?) -> Content){
        self.init(url: .init(string: url), content: content)
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
}

#if DEBUG
struct RemoteImage_Image_PreviewView: PreviewProvider {
    static var previews: some View {
        VStack{
            RemoteImage(url: "https://loremflickr.com/400/400") { image, error in
                if let _ = error {
                    Text("Error")
                } else if let image {
                    image
                } else {
                    Text("Downloading")
                }
            }
            .force(true)
            RemoteImage(url: "--") { image, error in
                if let error {
                    Text("Error: \(error.debugDescription)")
                        .font(.system(size: 10))
                } else if let image {
                    image
                } else {
                    Text("Downloading")
                }
            }
            .force(true)
        }
    }
}
#endif
