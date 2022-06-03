//
//  BackgroundThreadBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/3/22.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            DispatchQueue.main.async {
                self.dataArray = newData
            }
            
        }
        
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
    
    
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10 ){
                Text("Load Data")
                    .font(.title)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                        print("tapped")
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
