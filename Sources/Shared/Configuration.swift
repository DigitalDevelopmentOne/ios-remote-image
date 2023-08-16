/*
 
 Project: RemoteImage
 File: Configuration.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

public struct Configuration {
    public init(
        cacheProvider: CacheProvider.Type = Memory.self,
        remoteDataProvider: RemoteDataProvider.Type = Network.self,
        handler: Handler.Type = Crypto.self) {
            self.cacheProvider = cacheProvider
            self.remoteDataProvider = remoteDataProvider
            self.handler = handler
    }
    let cacheProvider: CacheProvider.Type
    let remoteDataProvider: RemoteDataProvider.Type
    let handler: Handler.Type
    
    static let `default`: Configuration = .init()
    
    public func install(){
        Storage.configure(self)
    }
    
}
