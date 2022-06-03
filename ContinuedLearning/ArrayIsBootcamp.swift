//
//  ArrayIsBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/3/22.
//

import SwiftUI

class ArrayModificationViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var filtered: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        // sort
        // filter
        // map
        
        // sorting method
        // filtered = users.sorted(by: { $0.points > $1.points})
        
        // filter method
        // filtered = users.filter({$0.points > 50 })
        
        // map method
        mappedArray = users.map({$0.name})
        
        
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", points: 0, isVerified: true)
        let user3 = UserModel(name: "Joe", points: 43, isVerified: false)
        let user4 = UserModel(name: "Emily", points: 7, isVerified: false)
        let user5 = UserModel(name: "Samantha", points: 35, isVerified: false)
        let user6 = UserModel(name: "Jason", points: 70, isVerified: true)
        let user7 = UserModel(name: "Sarah", points: 56, isVerified: true)
        let user8 = UserModel(name: "Lisa", points: 61, isVerified: false)
        let user9 = UserModel(name: "Steve", points: 78, isVerified: true)
        let user10 = UserModel(name: "Amanda", points: 100, isVerified: true)
        self.users.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
    }
    
}

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
}

struct ArrayIsBootcamp: View {
    @StateObject var vm = ArrayModificationViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing:20) {
                ForEach(vm.mappedArray, id: \.self){user in
                    Text(user)
                }
                
//                ForEach(vm.filtered) { user in
//                    VStack(alignment:.leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArrayIsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArrayIsBootcamp()
    }
}
