/*
 
 Project: RemoteImage
 File: ViewModel.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import SwiftUI

public final class ViewModel: ObservableObject, RemoteDataProviderDelegate {
    public func setProgress(value: CGFloat) {
        self.setState(.fetch(progress: value))
    }
    
    let cacheProvider: CacheProvider
    var remoteDataProvider: RemoteDataProvider
    let handler: Handler
    var state: State

    
    func toMainThread(action: @escaping () -> Void){
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }

    init(){
        let configuration: Configuration
        if let remoteImageConfiguration = Storage.configuration {
            configuration = remoteImageConfiguration
        } else {
            configuration = .default
            Storage.configure(configuration)
        }
        self.cacheProvider = configuration.cacheProvider.instance()
        self.remoteDataProvider = configuration.remoteDataProvider.init()
        self.handler = configuration.handler.init()
        self.state = .inaction
    }
    
    func fetchImage(url: URL?, observable: Bool){
        func worker(){
            self.setState(.fetch(progress: nil))
            guard let url else {
                self.setState(.failure(error: .incorrectUrl(message: "Can't be nil")))
                return
            }
            let key = self.handler.transform(from: url)
            
            if let data = self.cacheProvider.get(from: key), let image = UIImage(data: data) {
                self.setState(.success(image: image))
                return
            }
            if observable {
                self.remoteDataProvider.delegate = self
            }
            self.remoteDataProvider.download(url: url) { result in
                switch result {
                case .success(let data):
                    self.cacheProvider.save(data: data, key: key) { status in
                        guard status else {
                            self.setState(.failure(error: .preservation(message: "key: \(key)")))
                            return
                        }
                        guard let image = UIImage(data: data) else {
                            self.setState(.failure(error: .imageAssembly(message: "key: \(key)")))
                            return
                        }
                        self.setState(.success(image: image))
                    }
                case .failure(let error):
                    self.setState(.failure(error: error))
                }
            }
        }
        self.toMainThread(action: worker)
    }
    
    func setState(_ value: State){
        func worker(){
            self.objectWillChange.send()
            self.state = value
        }
        self.toMainThread(action: worker)
    }
}