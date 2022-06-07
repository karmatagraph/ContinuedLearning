//
//  DownloadingImagesViewModel.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModels in
                guard let self = self else { return }
                self.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}
