/*
 
 Project: RemoteImage
 File: RemoteImage+Option.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    enum Option {
        case state((_ state: State) -> Content)
        case uiImage((UIImage?, Error?) -> Content)
        case uiImageWithProgress((UIImage?, Error?, CGFloat) -> Content)
        case image((Image?, Error?) -> Content)
        case imageWithProgress((Image?, Error?, CGFloat) -> Content)
    }
}
