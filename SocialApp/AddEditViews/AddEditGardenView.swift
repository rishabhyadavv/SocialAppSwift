//
//  AddEditGardenView.swift
//  SocialApp
//
//  Created by Rishabh Yadav on 15.07.24.
//

import Foundation
import SwiftUI

struct AddEditGardenView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AnyItemViewModel
    @State private var name: String = ""
    @State private var plantType: String = ""
    @State private var details: String = ""
    var item: GardenItem?
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Plant Type", text: $plantType)
                TextField("Details", text: $details)
            }
            .navigationTitle(item == nil ? "Add Garden Item" : "Edit Garden Item")
            .navigationBarItems(trailing: Button("Save") {
                let newItem = GardenItem(id: item?.id ?? UUID(), name: name, details: details, plantType: plantType)
                
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
                    plantType = item.plantType
                    details = item.details
                }
            }
        }
    }
}

