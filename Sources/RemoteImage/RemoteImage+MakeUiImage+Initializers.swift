/*
 
 Project: RemoteImage
 File: RemoteImage+MakeUiImage+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    ///Get UIImage with error from url
    public init(
        url: URL?,
        @ViewBuilder content: @escaping (_ uiImage: UIImage?, _ error: Error?) -> Content){
            self.init(url: url, observable: false, option: .uiImage(content))
        }
    ///Get UIImage with error from urlString
    public init(
        url: String,
        @ViewBuilder content: @escaping (_ uiImage: UIImage?, _ error: Error?) -> Content){
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
