//
//  File.swift
//  
//
//  Created by Егор Бойко on 14.08.2023.
//

import Foundation


struct Storage {
    static var configuration: Configuration?
    static func configure(_ configuration: Configuration = .default){
        self.configuration = configuration
    }
}
