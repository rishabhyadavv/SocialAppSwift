//
//  ItemModels.swift
//  SocialApp
//
//  Created by Rishabh Yadav on 15.07.24.
//

import Foundation



struct GroceryItem:ItemProtocol {
    var id: UUID
    var name: String
    var details: String
    var quantity: Int
}

struct GardenItem: ItemProtocol {
    var id: UUID
    var name: String
    var details: String
    var plantType: String
}
