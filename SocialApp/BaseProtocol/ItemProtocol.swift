//
//  GroceryProtocol.swift
//  SocialApp
//
//  Created by Rishabh Yadav on 15.07.24.
//

import Foundation


protocol ItemProtocol:Identifiable {
      var id: UUID { get }
      var name: String { get set }
      var details: String { get set }
}

protocol ItemViewModelProtocol {
    associatedtype ItemType: ItemProtocol
    var items:[ItemType] {get set}
    func addItem(item: ItemType)
    func editItem(item: ItemType)
    func deleteItem(item: ItemType)
    func itemDetails(for id: UUID) -> ItemType?
}


final class AnyItemViewModel: ObservableObject {
    @Published var items: [AnyItem] = []
    
    private let _addItem: (AnyItem) -> Void
    private let _editItem: (AnyItem) -> Void
    private let _deleteItem: (AnyItem) -> Void
    private let _itemDetails: (UUID) -> AnyItem?

    init<T: ItemViewModelProtocol>(_ viewModel: T) where T.ItemType == AnyItem {
        self._addItem = viewModel.addItem
        self._editItem = viewModel.editItem
        self._deleteItem = viewModel.deleteItem
        self._itemDetails = viewModel.itemDetails
        
        self.items = viewModel.items
    }
    
    func addItem(item: AnyItem) {
        _addItem(item)
    }
    
    func editItem(item: AnyItem) {
        _editItem(item)
    }
    
    func deleteItem(item: AnyItem) {
        _deleteItem(item)
    }
    
    func itemDetails(for id: UUID) -> AnyItem? {
        return _itemDetails(id)
    }
}

struct AnyItem: ItemProtocol {
    var id: UUID
    var name: String
    var details: String
    var wrappedItem: Any
    
    init<T: ItemProtocol>(_ item: T) {
        self.id = item.id
        self.name = item.name
        self.details = item.details
        self.wrappedItem = item
    }
}


