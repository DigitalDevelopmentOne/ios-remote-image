/*
 
 Project: RemoteImage
 File: ViewModel+Method+SetState.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import UIKit

extension ViewModel {
    func setState(_ value: State){
        func worker(){
            self.objectWillChange.send()
            self.state = value
        }
        self.toMainThread(action: worker)
    }
}
