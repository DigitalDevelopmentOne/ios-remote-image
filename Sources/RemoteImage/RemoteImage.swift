/*
 
 Project: RemoteImage
 File: RemoteImage.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import SwiftUI

public struct RemoteImage<Content: View>: View{
    init(
        url: URL?,
        observable: Bool,
        option: Option,
        configuration: Configuration? = nil,
        force: Bool = false) {
            self.url = url
            self.observable = observable
            self.option = option
            self.configuration = configuration
            self.force = force
    }

    @StateObject
    var viewModel: ViewModel = .init()
    let url: URL?
    let observable: Bool
    let option: Self.Option
    var configuration: Configuration?
    var force: Bool
    
    public var body: some View {
        self.makeContent()
            .onAppear(perform: self.onAppear)
    }
}
