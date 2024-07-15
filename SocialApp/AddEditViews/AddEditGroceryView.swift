//
//  AddEditGroceryView.swift
//  SocialApp
//
//  Created by Rishabh Yadav on 15.07.24.
//

import Foundation
import SwiftUI

struct AddEditGroceryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AnyItemViewModel
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var details: String = ""
    var item: GroceryItem?
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Quantity", text: $quantity)
                TextField("Details", text: $details)
            }
            .navigationTitle(item == nil ? "Add Grocery Item" : "Edit Grocery Item")
            .navigationBarItems(trailing: Button("Save") {
                let quantityInt = Int(quantity) ?? 0
                let newItem = GroceryItem(id: item?.id ?? UUID(), name: name, details: details, quantity: quantityInt)
                
                if let item = item {
                    viewModel.editItem(item: AnyItem(newItem))
                } else {
                    viewModel.addItem(item: AnyItem(newItem))
                }
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                if let item = item {
                    name = item.name
                    quantity = "\(item.quantity)"
                    details = item.details
                }
            }
        }
    }
}

