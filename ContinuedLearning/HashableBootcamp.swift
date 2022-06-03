//
//  HashableBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/2/22.
//

import SwiftUI

struct CustomModel:Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
}

struct HashableBootcamp: View {
    
    let data: [CustomModel] = [
        CustomModel(title: "ONE"),
        CustomModel(title: "TWO"),
        CustomModel(title: "THREE"),
        CustomModel(title: "FOUR"),
        CustomModel(title: "FIVE")
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 40){
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
