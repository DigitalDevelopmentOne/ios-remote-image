/*
 
 Project: RemoteImage
 File: RemoteImage+MakeImageWithProgress+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    ///Get Image with error and progress from url
    public init(
        url: URL?,
        @ViewBuilder content: @escaping (
            _ image: Image?,
            _ error: Error?,
            _ progress: CGFloat) -> Content){
                self.init(url: url, observable: true, option: .imageWithProgress(content))
            }
    ///Get Image with error and progress from urlString
    public init(
        url: String,
        @ViewBuilder content: @escaping (
            _ image: Image?,
            _ error: Error?,
            _ progress: CGFloat) -> Content){
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
