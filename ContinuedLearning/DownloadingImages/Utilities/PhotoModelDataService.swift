//
//  PhotoModelDataService.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    // Singleton
    static let instance = PhotoModelDataService()
    @Published var photoModels: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] models in
                guard let self = self else { return }
                self.photoModels = models
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}
