/*
 
 Project: RemoteImage
 File: Network.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public final class Network: RemoteDataProvider {
    public func cancel() {
        self.task?.cancel{ _ in }
    }
    public init(){}
    public weak var delegate: RemoteDataProviderDelegate?
    var observation: NSKeyValueObservation?
    var lastProgress: Int = 0
    var task: URLSessionDownloadTask?
}
