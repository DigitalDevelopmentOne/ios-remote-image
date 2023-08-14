/*
 
 Project: RemoteImage
 File: ViewModel.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import SwiftUI

public final class ViewModel: ObservableObject {
    let cacheProvider: CacheProvider
    let remoteDataProvider: RemoteDataProvider
    
    init(){
        let configuration: Configuration
        if let remoteImageConfiguration = RemoteImage.configuration {
            configuration = remoteImageConfiguration
        } else {
            configuration = .default
            RemoteImage.configure(configuration)
        }
        self.cacheProvider = configuration.cacheProvider.instance()
        self.remoteDataProvider = configuration.remoteDataProvider.instance()
    }
}
