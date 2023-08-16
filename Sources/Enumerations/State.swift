/*
 
 Project: RemoteImage
 File: State.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import UIKit

public enum State: Equatable {
    case inaction
    case fetch(progress: CGFloat)
    case success(image: UIImage)
    case failure(error: Error)
    
    var id: Int {
        switch self {
        case .inaction:
            return 1
        case .fetch(_):
            return 2
        case .success(_):
            return 3
        case .failure(_):
            return 4
        }
    }
    
    public static func == (lhs: State, rhs: State) -> Bool {
        lhs.id == rhs.id
    }
}
