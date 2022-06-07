//
//  ImageLoadingViewModel.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import Foundation
import Combine
import SwiftUI

class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    let urlString: String
    var cancellables = Set<AnyCancellable>()
    let manager = PhotoModelFileManager.instance
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func downloadImage() {
        print("downloading images")
        isLoading = true
        guard let url = URL(string: urlString)  else {
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self]_ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard
                    let self = self,
                    let image = returnedImage
                else { return }
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image!")
        } else {
            downloadImage()
            print("downloading image!")
        }
    }
    
}
