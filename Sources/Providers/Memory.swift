/*
 
 Project: RemoteImage
 File: Memory.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public final class Memory: CacheProvider {
    public func get(from value: String) -> Data? {
        let filePath = self.directory.appendingPathComponent(value)
        guard FileManager.default.fileExists(atPath: filePath.path),
              let nsData = NSData(contentsOfFile: filePath.path) else {
            return nil
        }
        return Data(referencing:nsData)
    }
    
    public func save(data: Data, key: String, handler: @escaping (_ status: Bool) -> ()) {
        let filePath = self.directory.appendingPathComponent(key)
        do {
            try data.write(to: filePath)
            handler(true)
        } catch {
            handler(false)
        }
    }
    
    public static func instance() -> Memory {
        .main
    }
    
    private static let main: Memory = .init()
    
    lazy var directory: URL = {
        let manager: FileManager, defaultPathsSearch: URL, newFolder: URL
        manager = .default

        do {
            defaultPathsSearch = try manager.url(
                for: FileManager.SearchPathDirectory.cachesDirectory,
                   in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil,
                   create: true)
        } catch {
            fatalError("Directory creation")
        }

        newFolder = defaultPathsSearch.appendingPathComponent("remote-image")

        if !manager.fileExists(atPath: newFolder.path){
            do {
                try manager.createDirectory(at: newFolder, withIntermediateDirectories: false, attributes: nil)
            }
            catch {
                fatalError("Directory creation")
            }
        }
        return newFolder
    }()

}
