/*
 
 Project: RemoteImage
 File: Memory+Method+Get.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import Foundation

extension Memory {
    public func get(from value: String) -> Data? {
        let filePath = self.directory.appendingPathComponent(value)
        guard FileManager.default.fileExists(atPath: filePath.path),
              let nsData = NSData(contentsOfFile: filePath.path) else {
            return nil
        }
        return Data(referencing:nsData)
    }
}
