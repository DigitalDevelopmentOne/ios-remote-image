/*
 
 Project: RemoteImage
 File: Handler.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import Foundation
import CryptoKit

public struct Crypto : Handler {
    
    public init(){}
    
    public func transform(from url: URL) -> String {
        guard let data = url.absoluteString.data(using: .utf8) else {
            return "-"
        }
        return Insecure.MD5.hash(data: data).map { String(format: "%02hhx", $0) }.joined()
    }

}
