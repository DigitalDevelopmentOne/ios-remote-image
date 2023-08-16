/*
 
 Project: RemoteImage
 File: ViewModel+Method+ToMainThread.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import Foundation

extension ViewModel {
    func toMainThread(action: @escaping () -> Void){
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}
