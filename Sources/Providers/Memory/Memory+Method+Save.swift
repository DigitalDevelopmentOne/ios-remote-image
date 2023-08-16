/*
 
 Project: RemoteImage
 File: Memory+Method+Save.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import Foundation

extension Memory {
    public func save(data: Data, key: String, handler: @escaping (_ status: Bool) -> ()) {
        let filePath = self.directory.appendingPathComponent(key)
        do {
            try data.write(to: filePath)
            handler(true)
        } catch {
            handler(false)
        }
    }
}
