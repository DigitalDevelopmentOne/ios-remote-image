/*
 
 Project: RemoteImage
 File: Error.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public enum Error: Swift.Error, CustomDebugStringConvertible {
    case incorrectUrl(message: String)
    case preservation(message: String)
    case imageAssembly(message: String)
    case remoteData(error: Swift.Error)
    case location(message: String)
    
    public var debugDescription: String {
        let label = "RemoteImage Error: "
        switch self {
        case .incorrectUrl(let message):
            return "\(label)incorrect url (\(message))"
        case .preservation(let message):
            return "\(label)preservation (\(message))"
        case .imageAssembly(let message):
            return "\(label)image assembly (\(message))"
        case .remoteData(let error):
            return "\(label)remoteData (\(error))"
        case .location(let message):
            return "\(label) location (\(message))"
        }
    }
}
