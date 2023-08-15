/*
 
 Project: RemoteImage
 File: Error.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public enum Error: Swift.Error, CustomDebugStringConvertible {
    case incorrectUrl(message: String)
    
    public var debugDescription: String {
        switch self {
        case .incorrectUrl(let message):
            return "RemoteImage Error: incorrect url (\(message)"
        }
    }
}
