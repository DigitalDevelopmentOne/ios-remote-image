/*
 
 Project: RemoteImage
 File: Memory+Static.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import Foundation

extension Memory {
    static let main: Memory = .init()
    public static func instance() -> Memory {
        .main
    }
}
