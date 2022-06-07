//
//  DownloadingImagesBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import SwiftUI

// codable
// background threads
// weak self
// combine
// publishers and subscribers
// file manager
// NSCache

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) {model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading images")
        }
    }
}



struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
