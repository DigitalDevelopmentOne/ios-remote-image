/*
 
 Project: RemoteImage
 File: RemoteImage+MakeContent.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    @ViewBuilder
    func makeContent() -> some View {
        switch self.option {
        case .state(let content):
            content(self.viewModel.state)
        case .uiImage(let content):
            self.makeUiImage(content: content)
        case .image(let content):
            self.makeImage(content: content)
        case .uiImageWithProgress(let content):
            self.makeUiImageWithProgress(content: content)
        case .imageWithProgress(let content):
            self.makeImageWithProgress(content: content)
        }
    }
}
