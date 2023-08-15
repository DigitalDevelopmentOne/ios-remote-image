/*
 
 Project: RemoteImage
 File: CacheProvider.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

public protocol Provider {
    static func instance() -> Self
}
