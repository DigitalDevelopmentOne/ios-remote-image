/*
 
 Project: RemoteImage
 File: RemoteImage+Modifiers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */


extension RemoteImage {
    public func configuration(_ value: Configuration) -> Self {
        var view = self
        view.configuration = configuration
        return view
    }
    
//    public func cacheProvider(_ value: CacheProvider) -> Self {
//        
//    }
    
    public func force(_ value: Bool) -> Self {
        var view = self
        view.force = value
        return view
    }
}
