//
//  DetailView.swift
//  SocialApp
//
//  Created by Rishabh Yadav on 15.07.24.
//

import Foundation

import SwiftUI

struct DetailView<Item: ItemProtocol>: View {
    var item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(item.name)")
            Text("Details: \(item.details)")
            if let groceryItem = item as? GroceryItem {
                Text("Quantity: \(groceryItem.quantity)")
            } else if let gardenItem = item as? GardenItem {
                Text("Plant Type: \(gardenItem.plantType)")
            }
        }
        .navigationTitle("Item Details")
        .padding()
    }
}
