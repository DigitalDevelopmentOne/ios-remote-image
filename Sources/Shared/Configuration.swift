/*
 
 Project: RemoteImage
 File: Configuration.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

struct Configuration {
    let cacheProvider: CacheProvider.Type
    let remoteDataProvider: RemoteDataProvider.Type
    let handler: Handler.Type
    
    static let `default`: Configuration = .init(
        cacheProvider: Memory.self,
        remoteDataProvider: Network.self,
        handler: Crypto.self
    )
}
