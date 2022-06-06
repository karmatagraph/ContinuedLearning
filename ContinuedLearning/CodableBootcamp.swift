//
//  CodableBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/6/22.
//

import SwiftUI

struct CustomerModel: Codable, Identifiable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    enum CodinKeys: String, CodingKey {
        case id, name, points, isPremium
    }
    
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodinKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodinKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(points, forKey: .points)
        try container.encode(isPremium, forKey: .isPremium)
    }
    
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil// CustomerModel(id: "1", name: "Nick", points: 5, isPremium: true)
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else {
            return
        }
        //        print(data)
        //        let jsonString = String(data: data, encoding: .utf8)
        //        print(jsonString)
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data),
//            let dictionary = localData as? [String:Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool {
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        
        
    }
    
    func getJSONData() -> Data? {
        let customer = CustomerModel(id: "111", name: "Emily", points: 100, isPremium: false)
        
//        let dictionary: [String: Any] = [
//            "id": "12345",
//            "name": "joe",
//            "points": 5,
//            "isPremium": true
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonData = try? JSONEncoder().encode(customer )
        return jsonData
    }
    
}

struct CodableBootcamp: View {
    @StateObject var vm = CodableViewModel()
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
