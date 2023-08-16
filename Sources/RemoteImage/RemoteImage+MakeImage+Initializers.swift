/*
 
 Project: RemoteImage
 File: RemoteImage+MakeImage+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    ///Get Image with error from url
    public init(
        url: URL?,
        @ViewBuilder content: @escaping (_ image: Image?, _ error: Error?) -> Content){
            self.init(url: url, observable: false, option: .image(content))
    }
    ///Get Image with error from urlString
    public init(
        url: String,
        @ViewBuilder content: @escaping (_ image: Image?, _ error: Error?) -> Content){
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
