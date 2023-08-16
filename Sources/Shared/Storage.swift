/*
 
 Project: RemoteImage
 File: Storage.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

struct Storage {
    static var configuration: Configuration?
    static func configure(_ configuration: Configuration = .default){
        self.configuration = configuration
    }
}
