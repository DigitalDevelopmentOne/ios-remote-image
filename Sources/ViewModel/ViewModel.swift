/*
 
 Project: RemoteImage
 File: ViewModel.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import SwiftUI

public final class ViewModel: ObservableObject {
    init(){
        self.cacheProvider = Storage.configuration.cacheProvider.instance()
        self.remoteDataProvider = Storage.configuration.remoteDataProvider.init()
        self.handler = Storage.configuration.handler.init()
        self.state = .inaction
    }
    var cacheProvider: CacheProvider
    var remoteDataProvider: RemoteDataProvider
    var handler: Handler
    var state: State
    func cancel(){
        self.remoteDataProvider.cancel()
        self.setState(.inaction)
    }
}
