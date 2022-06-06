//
//  DownloadWithEscapingBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/6/22.
//

import SwiftUI

//struct Posts: Codable, Identifiable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}

typealias posts = ([Posts])-> Void

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var item: [Posts] = []
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        downloadData(url: url) { [weak self] post in
            DispatchQueue.main.async {
                self?.item = post
            }
        }
        
        
    }
    
    func downloadData(url: URL, completion: @escaping posts) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("downloading data failed")
                return
            }
            
            do{
                let data = try JSONDecoder().decode([Posts].self, from: data)
                //                    self.item = data
                completion(data)
            } catch let error {
//                completion(nil)
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    ForEach(vm.item) {item in
                        Text(item.title)
                            .font(.headline)
                            
                        Text(item.body)
                            .padding()
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                    }
                }
                .padding(20)
            }
            .navigationTitle("Posts")
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
