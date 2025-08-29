//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by GS Agrawal on 28/08/25.
//

import Foundation


struct RoomType: Equatable{
    var id : Int
    var name : String
    var shortName: String
    var price : Int
    
    static func == (lhs: RoomType, rhs: RoomType) -> Bool{
        return lhs.id == rhs.id
    }
    static var all : [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 900),
                RoomType(id: 1, name: "One King", shortName: "K", price: 400),
                RoomType(id: 2, name: "Penthouse Suit", shortName: "PHS", price: 1300)]
    }
}


