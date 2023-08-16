/*
 
 Project: RemoteImage
 File: RemoteImage+MakeContent.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage: Equatable {
    public static func == (lhs: RemoteImage<Content>, rhs: RemoteImage<Content>) -> Bool {
        lhs.url == rhs.url
    }
}
