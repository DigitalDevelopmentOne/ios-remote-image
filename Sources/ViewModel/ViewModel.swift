/*
 
 Project: RemoteImage
 File: ViewModel.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import SwiftUI

public final class ViewModel: ObservableObject {
    init(){
        let configuration: Configuration
        if let remoteImageConfiguration = Storage.configuration {
            configuration = remoteImageConfiguration
        } else {
            configuration = .default
            Storage.configure(configuration)
        }
        self.cacheProvider = configuration.cacheProvider.instance()
        self.remoteDataProvider = configuration.remoteDataProvider.init()
        self.handler = configuration.handler.init()
        self.state = .inaction
    }
    var cacheProvider: CacheProvider
    var remoteDataProvider: RemoteDataProvider
    var handler: Handler
    var state: State
}
