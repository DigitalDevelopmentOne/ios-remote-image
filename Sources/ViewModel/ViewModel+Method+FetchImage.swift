/*
 
 Project: RemoteImage
 File: ViewModel+Method+FetchImage.swift
 Created by: Egor Boyko
 Date: 15.08.2023
 
 */

import UIKit

extension ViewModel {
    func fetchImage(url: URL?, observable: Bool, force: Bool){
        func worker(){
            self.setState(.fetch(progress: 0))
            guard let url else {
                self.setState(.failure(error: .incorrectUrl(message: "Can't be nil")))
                return
            }
            let key = self.handler.transform(from: url)
            
            if !force, let data = self.cacheProvider.get(from: key), let image = UIImage(data: data) {
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
}
