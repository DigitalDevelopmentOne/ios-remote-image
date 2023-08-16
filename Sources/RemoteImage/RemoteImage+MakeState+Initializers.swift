/*
 
 Project: RemoteImage
 File: RemoteImage+MakeState+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    ///Get Image state from url
    public init(
        url: URL?,
        @ViewBuilder content: @escaping (_ state: State) -> Content){
            self.init(url: url, observable: true, option: .state(content))
        }
    ///Get Image state from urlString
    public init(
        url: String,
        @ViewBuilder content: @escaping (_ state: State) -> Content){
            self.init(url: .init(string: url), content: content)
        }
    
    @ViewBuilder
    func makeState(content: (State) -> Content) -> some View {
        content(self.viewModel.state)
    }
}
