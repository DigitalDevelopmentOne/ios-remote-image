/*
 
 Project: RemoteImage
 File: RemoteDataProvider.swift
 Created by: Egor Boyko
 Date: 14.08.2023
 
 */

import Foundation

public protocol RemoteDataProvider {
    init()
    var delegate: RemoteDataProviderDelegate? { get set }
    func download(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
    func cancel()
}
