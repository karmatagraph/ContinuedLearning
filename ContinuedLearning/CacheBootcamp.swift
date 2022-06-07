//
//  CacheBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import SwiftUI

class CacheManager {
    
    // Singleton
    static let instance = CacheManager()
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "added to cache"
        
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "remove from cache!"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}

class CacheViewModel:ObservableObject {
    
    let imageName = "index"
    let manager = CacheManager.instance
    @Published var startImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssets()
    }
    
    func getImageFromAssets() {
        startImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startImage else {
            return
        }

        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            infoMessage = "got image from cache"
            cachedImage = returnedImage
        } else {
            infoMessage = "image not found in cache"
            cachedImage = manager.get(name: imageName)
        }
    }
    
}

struct CacheBootcamp : View {
    @StateObject var vm = CacheViewModel()
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                if let image = vm.startImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("save to cache")
                            .font(.headline)
                            .frame(height: 55)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete from cache")
                            .font(.headline)
                            .frame(height: 55)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from cache")
                        .font(.headline)
                        .frame(height: 55)
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .cornerRadius(10)
                }
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                    .padding()
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}
