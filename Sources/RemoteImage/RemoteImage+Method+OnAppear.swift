/*
 
 Project: RemoteImage
 File: RemoteImage+Method+OnAppear.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

extension RemoteImage {
    func onAppear(){
        if let configuration {
            self.viewModel.cacheProvider = configuration.cacheProvider.instance()
            self.viewModel.handler = configuration.handler.init()
            self.viewModel.remoteDataProvider = configuration.remoteDataProvider.init()
        }
        self.viewModel.fetchImage(
            url: self.url,
            observable: self.observable,
            force: self.force
        )
    }
}
