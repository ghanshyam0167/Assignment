//
//  Registration.swift
//  Hotel Manzana
//
//  Created by GS Agrawal on 28/08/25.
//

import Foundation

struct Registration {
    var firstName : String
    var lastName : String
    var emailAddress : String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults : Int
    var numberOfChild : Int
    
    var wifi : Bool
    var roomType : RoomType
}
