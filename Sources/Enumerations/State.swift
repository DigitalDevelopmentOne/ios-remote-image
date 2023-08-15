/*
 
 Project: RemoteImage
 File: State.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import UIKit

public enum State {
    case inaction
    case fetch(progress: CGFloat?)
    case success(image: UIImage)
    case failure(error: Error)
}
