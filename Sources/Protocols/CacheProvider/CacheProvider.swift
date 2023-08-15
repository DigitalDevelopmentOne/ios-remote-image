/*
 
 Project: RemoteImage
 File: CacheProvider.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public protocol CacheProvider {
    static func instance() -> Self
    func get(from: String) -> Data?
    func save(data: Data, key: String, handler: @escaping (_ status: Bool) -> ())
}
