/*
 
 Project: RemoteImage
 File: Memory.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public final class Memory: CacheProvider {
    lazy var directory: URL = self.getDirectory()
}
