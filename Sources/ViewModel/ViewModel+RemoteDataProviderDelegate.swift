/*
 
 Project: RemoteImage
 File: ViewModel+RemoteDataProviderDelegate.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

extension ViewModel: RemoteDataProviderDelegate {
    public func setProgress(value: CGFloat) {
        self.setState(.fetch(progress: value))
    }
}
