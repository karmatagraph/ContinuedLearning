//
//  PhotoModel.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import Foundation
// model json format
/*
//{
//"albumId": 1,
//"id": 1,
//"title": "accusamus beatae ad facilis cum similique qui sunt",
//"url": "https://via.placeholder.com/600/92c952",
//"thumbnailUrl": "https://via.placeholder.com/150/92c952"
//}
*/
struct PhotoModel: Codable, Identifiable {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
 
}
