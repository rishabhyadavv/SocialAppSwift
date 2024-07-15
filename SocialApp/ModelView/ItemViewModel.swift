//
//  ItemViewModel.swift
//  SocialApp
//
//  Created by Rishabh Yadav on 15.07.24.
//

import Foundation




class ItemViewModel<T: ItemProtocol>: ObservableObject, ItemViewModelProtocol {
    @Published var items: [T] = []
    
    func addItem(item: T) {
        items.append(item)
    }
    
    func editItem(item: T) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        }
    }
    
    func deleteItem(item: T) {
        items.removeAll { $0.id == item.id }
    }
    
    func itemDetails(for id: UUID) -> T? {
        return items.first { $0.id == id }
    }
}


