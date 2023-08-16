# Remote Image

Use to download images from a remote resource. You can use your own providers for loading and caching.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding RemoteImage as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/DigitalDevelopmentOne/ios-remote-image.git", .upToNextMajor(from: "0.0.1"))
]
```

## Usage

If you don't want to, then there is no need to create your own providers. the package provides everything you need by default.

### Create a configuration
#### Cache Provider
```swift

  final class ExampleCacheProvider: CacheProvider {
    static func instance() -> Self {
        //Provide a shared or limited instance to work with
    }
    
    func get(from: String) -> Data? {
        //Getting the cached date
    }
    
    func save(data: Data, key: String, handler: @escaping (Bool) -> ()) {
        //Save the cached date
    }
}
            
```

#### Remote data Provider
The default is the shared URLSession of the instance.
```swift

final class ExampleRemoteDataProvider: RemoteDataProvider {
    //Just implement this property, the assignment happens without your participation
    var delegate: RemoteDataProviderDelegate?
    
    func download(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        //Image acquisition method
    }
}
            
```

#### Handler
You need a conversion method to get filename/key from URL.
```swift

struct ExampleHandler: Handler {
    func transform(from url: URL) -> String {
        //Implementation
    }
}
            
```

#### Global configuration
Perform the configuration and install it anywhere before the first appearance of any of your Views.

```swift

//...

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            
            
            let configuration: Configuration = .init(
                cacheProvider: ExampleCacheProvider.self,
                remoteDataProvider: ExampleRemoteDataProvider.self,
                handler: ExampleHandler.self
            )
            
            configuration.install()
            
//...
            
```

#### Single image configuration
The configuration will be active for the current instance

```swift

RemoteImage(url: nil) { image, error in
    //...code
}
.configuration(configuration)
            
```

### Use cases
Each of the initializers supports URL and String values.
#### Use state

```swift

RemoteImage(url: "https://example.com/image.jpg") { state in
    switch state {
    case .fetch(let progress):
        Text("\(progress)")
    case .inaction:
        Text("inaction")
    case .success(let image):
        Image(uiImage: image)
    case .failure(let error):
        Text("Error: \(error.debugDescription)")
    }
}
            
```

### Get UIImage

```swift

RemoteImage(url: "https://example.com/image.jpg") { uiImage, error in
    if let error {
        Text("Error: \(error.debugDescription)")
    } else if let uiImage {
        Image(uiImage: uiImage)
    } else {
        Text("Downloading")
    }
}
            
```

### Get UIImage with progress

```swift

RemoteImage(url: "https://example.com/image.jpg") { uiImage, error, progress in
    if let error {
        Text("Error: \(error.debugDescription)")
    } else if let uiImage {
        Image(uiImage: uiImage)
    } else {
        Text("Downloading: \(progress)")
    }
}
            
```

### Get Image

```swift

RemoteImage(url: "https://example.com/image.jpg") { image, error in
    if let error {
        Text("Error: \(error.debugDescription)")
    } else if let image {
        image
    } else {
        Text("Downloading")
    }
}
            
```

### Get Image with progress

```swift

RemoteImage(url: "https://example.com/image.jpg") { image, error, progress in
    if let error {
        Text("Error: \(error.debugDescription)")
    } else if let image {
        image
    } else {
        Text("Downloading: \(progress)")
    }
}
            
```

## Additionally
### Caching
If you do not want to take the image from the cache, use the modifier `force`

```swift

RemoteImage(url: "https://example.com/image.jpg") { image, error, progress in
    if let error {
        Text("Error: \(error.debugDescription)")
    } else if let image {
        image
    } else {
        Text("Downloading: \(progress)")
    }
}
.force(true)

```
### Note 
The provider by default uses the system directory for the cache, which the system frees without your
