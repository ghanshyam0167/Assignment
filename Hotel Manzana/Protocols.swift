//
//  Protocols.swift
//  Hotel Manzana
//
//  Created by GS Agrawal on 28/08/25.
//

import Foundation

protocol SelectRoomTableViewControllerDelegate : AnyObject {
    func selectRoomTableViewController(_ controller : SelectRoomTableViewController, didSelect roomType : RoomType)
}
