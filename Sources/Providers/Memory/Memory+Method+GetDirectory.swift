/*
 
 Project: RemoteImage
 File: Memory+Method+GetDirectory.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import Foundation

extension Memory {
    func getDirectory() -> URL {
        let manager: FileManager, defaultPathsSearch: URL, newFolder: URL
        manager = .default

        do {
            defaultPathsSearch = try manager.url(
                for: FileManager.SearchPathDirectory.cachesDirectory,
                   in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil,
                   create: true)
        } catch {
            fatalError("Search directory")
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
    }
}
