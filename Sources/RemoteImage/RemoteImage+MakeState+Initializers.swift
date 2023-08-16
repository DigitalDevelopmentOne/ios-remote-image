/*
 
 Project: RemoteImage
 File: RemoteImage+MakeState+Initializers.swift
 Created by: Egor Boyko
 Date: 16.08.2023
 
 */

import SwiftUI

extension RemoteImage {
    public init(url: URL?, @ViewBuilder content: @escaping (State) -> Content){
        self.init(url: url, observable: true, option: .state(content))
    }
    
    public init(url: String, @ViewBuilder content: @escaping (State) -> Content){
        self.init(url: .init(string: url), content: content)
    }
    
    @ViewBuilder
    func makeState(content: (State) -> Content) -> some View {
        content(self.viewModel.state)
    }
}

#if DEBUG
struct RemoteImage_State_PreviewView: PreviewProvider {
    static var previews: some View {
        VStack{
            RemoteImage(url: "https://loremflickr.com/400/400") { state in
                switch state {
                case .fetch(let progress):
                    Text("\(progress)")
                case .inaction:
                    Text("inaction")
                case .success(let image):
                    Image(uiImage: image)
                case .failure(let error):
                    Text("Error: \(error.debugDescription)")
                        .font(.system(size: 10))
                }
            }
            .force(true)
            RemoteImage(url: "__") { state in
                switch state {
                case .fetch(let progress):
                    Text("\(progress)")
                case .inaction:
                    Text("inaction")
                case .success(let image):
                    Image(uiImage: image)
                case .failure(let error):
                    Text("Error: \(error.debugDescription)")
                        .font(.system(size: 10))
                }
            }
            .force(true)
        }
    }
}
#endif
