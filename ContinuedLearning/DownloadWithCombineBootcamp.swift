//
//  DownloadWithCombineBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/6/22.
//

import SwiftUI
import Combine

struct Posts: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    @Published var post: [Posts] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        // Combine discussion:
        /*
        // 1. signup for monthly subscription for package to be delivered
        // 2. the company will make the package and behind the scene
        // 3. receive the package in your front door
        // 4. make sure the box isn't damadged
        // 5. open and make sure your item is correct
        // 6. use the item!!!!
        // 7. cancllable at any time
        
        // 1. create the publisher
        // 2. subscribe the publisher in the background thread / by default the URLSESSION TAKES CARE OF IT
        // 3. revceive on main thread
        // 4. tryMap (check the data is good)
        // 5. decode (decode data into Post data model)
        // 6. sink (put the item into our app)
        // 7. store (cancel the subscription if needed)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background)) // we dont need this line because url session auto does it
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Posts].self, decoder:JSONDecoder() )
            .sink { completion in
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] posts in
                self?.post = posts
            }
            .store(in: &cancellables)

            
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct DownloadWithCombineBootcamp: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.post) {post in
                    VStack(alignment: .leading, spacing: 20) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .padding()
                            .font(.subheadline)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct DownloadWithCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineBootcamp()
    }
}
