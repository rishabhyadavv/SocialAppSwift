//
//  ContentView.swift
//  SocialApp
//
//  Created by Rishabh Yadav on 15.07.24.
//

import SwiftData

import SwiftUI

struct ContentView: View {
    @StateObject private var groceryViewModel = AnyItemViewModel(ItemViewModel<AnyItem>())
    @StateObject private var gardenViewModel = AnyItemViewModel(ItemViewModel<AnyItem>())
    @State private var isAddingGrocery = false
    @State private var isAddingGarden = false
    @State private var selectedItem: AnyItem?
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Groceries")) {
                    ForEach(groceryViewModel.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            if let groceryItem = item.wrappedItem as? GroceryItem {
                                Text("\(groceryItem.quantity)")
                            }
                        }
                        .onTapGesture {
                            selectedItem = item
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            groceryViewModel.deleteItem(item: groceryViewModel.items[index])
                        }
                    }
                }
                
                Section(header: Text("Garden Items")) {
                    ForEach(gardenViewModel.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            if let gardenItem = item.wrappedItem as? GardenItem {
                                Text(gardenItem.plantType)
                            }
                        }
                        .onTapGesture {
                            selectedItem = item
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            gardenViewModel.deleteItem(item: gardenViewModel.items[index])
                        }
                    }
                }
            }
            .navigationTitle("Items List")
            .navigationBarItems(trailing: HStack {
                Button(action: { isAddingGrocery = true }) {
                    Image(systemName: "plus.circle").foregroundColor(.blue)
                }
                Button(action: { isAddingGarden = true }) {
                    Image(systemName: "plus.circle.fill").foregroundColor(.green)
                }
            })
            .sheet(isPresented: $isAddingGrocery) {
                AddEditGroceryView(viewModel: groceryViewModel, item: nil)
            }
            .sheet(isPresented: $isAddingGarden) {
                AddEditGardenView(viewModel: gardenViewModel, item: nil)
            }
            .sheet(item: $selectedItem) { item in
                if let groceryItem = item.wrappedItem as? GroceryItem {
                    DetailView(item: groceryItem)
                } else if let gardenItem = item.wrappedItem as? GardenItem {
                    DetailView(item: gardenItem)
                }
            }
        }
    }
}



//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
