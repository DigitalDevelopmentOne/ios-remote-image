/*
 
 Project: RemoteImage
 File: Network.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public final class Network : RemoteDataProvider {
    public weak var delegate: RemoteDataProviderDelegate?
    var observation: NSKeyValueObservation?
    var lastProgress: Int = 0
    
    public init(){}
    
    public func download(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.downloadTask(with: url){ location, _, error in
            if let error = error {
                handler(.failure(.remoteData(error: error)))
                return
            }
            guard let localUrl = location else {
                handler(.failure(.location(message: "Not found")))
                return
            }
            
 
            guard FileManager.default.fileExists(atPath: localUrl.path),
            let nsData = NSData(contentsOfFile: localUrl.path) else {
                handler(.failure(.location(message: "Date is incorrect")))
                return
            }
            handler(.success(.init(referencing: nsData)))
        }
        
        if let delegate {
            self.observation = task.progress.observe(\.fractionCompleted) { progress, _  in
                let progress = Int(progress.fractionCompleted * 10)
                if self.lastProgress != progress && progress % 2 == 0 {
                    self.lastProgress = progress
                    DispatchQueue.main.async {
                        delegate.setProgress(value: CGFloat(progress) / 10)
                    }
                }
            }
        }
        task.resume()
    }
}
