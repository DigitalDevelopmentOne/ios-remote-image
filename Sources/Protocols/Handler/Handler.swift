/*
 
 Project: RemoteImage
 File: Handler.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import Foundation

public protocol Handler {
    init()
    func transform(from url: URL) -> String
}
