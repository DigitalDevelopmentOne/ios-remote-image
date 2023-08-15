/*
 
 Project: RemoteImage
 File: RemoteDataProvider.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public protocol RemoteDataProviderDelegate: AnyObject {
    func setProgress(value: CGFloat)
}
