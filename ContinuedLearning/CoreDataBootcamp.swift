//
//  CoreDataBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/3/22.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    @Published var savedEntities: [FruitEntity] = []
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription, "error loading data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print(error.localizedDescription, "error fetching from")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(_ entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print(error.localizedDescription, "error saving data")
        }
    }
    
}

struct CoreDataBootcamp: View {
    @StateObject var vm = CoreDataViewModel()
    @State var textfiledText: String = ""
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                TextField("Add fruit here",text: $textfiledText)
                    .padding()
                    .font(.headline)
                    .frame(height:55)
                    .background(.thinMaterial)
                    .cornerRadius(10)
                Button {
                    guard !textfiledText.isEmpty else {
                        return
                    }
                    vm.addFruit(text: textfiledText)
                    textfiledText = ""
                } label: {
                    Text("Add")
                        .padding()
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "No name")
                            .font(.headline)
                            .onTapGesture {
                                vm.updateFruit(entity)
                            }
                        
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(.plain)
                
            }
            .padding()
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
