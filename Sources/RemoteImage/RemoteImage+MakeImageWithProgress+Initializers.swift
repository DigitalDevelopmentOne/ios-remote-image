/*
 
 Project: RemoteImage
 File: RemoteImage+MakeImageWithProgress+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    public init(url: URL?, @ViewBuilder content: @escaping (Image?, Error?, CGFloat) -> Content){
        self.init(url: url, observable: true, option: .imageWithProgress(content))
    }
    
    public init(url: String, @ViewBuilder content: @escaping (Image?, Error?, CGFloat) -> Content){
        self.init(url: .init(string: url), content: content)
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
}

#if DEBUG
struct RemoteImage_ImageWithProgress_PreviewView: PreviewProvider {
    static var previews: some View {
        VStack{
            RemoteImage(url: "https://loremflickr.com/400/400") { image, error, progress in
                if let _ = error {
                    Text("Error")
                } else if let image {
                    image
                } else {
                    Text("Downloading: \(progress)")
                }
            }
            .force(true)
            RemoteImage(url: "--") { image, error, progress in
                if let error {
                    Text("Error: \(error.debugDescription)")
                        .font(.system(size: 10))
                } else if let image {
                    image
                } else {
                    Text("Downloading: \(progress)")
                }
            }
            .force(true)
        }
    }
}
#endif
