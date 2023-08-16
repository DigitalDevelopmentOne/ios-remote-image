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
        self.contentWrapper{
            switch self.option {
            case .state(let content):
                self.makeState(content: content)
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
    
    @ViewBuilder
    private func contentWrapper<T: View>(@ViewBuilder content: () -> T) -> some View {
        if self.viewModel.state != .inaction {
            content()
                .onDisappear{
                    self.viewModel.setState(.inaction)
                }
        } else {
            content()
        }
    }
}
