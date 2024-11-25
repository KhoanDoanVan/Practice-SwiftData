//
//  NewPlant.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import SwiftUI
import SwiftData

struct NewPlant: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var isSheetSpecy: Bool = false
    
    @State private var namePlant: String = ""
    let user: User
    let plant: Plant?
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    LabeledContent("Name") {
                        TextField("", text: $namePlant, prompt: Text("Name"))
                    }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            if let species = plant?.species {
                                ForEach(species) { specy in
                                    Text(specy.name)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 8)
                                        .background(specy.hexColor)
                                        .clipShape(
                                            .rect(cornerRadius: 10)
                                        )
                                }
                            }
                        }
                    }
                    
                    Button {
                        isSheetSpecy.toggle()
                    } label: {
                        Text("Add Specy")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundStyle(.white)
                            .background(Color.blue)
                            .clipShape(
                                .rect(cornerRadius: 10)
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Button {
                        if plant != nil {
                            updatePlant()
                        } else {
                            insertPlant()
                        }
                        dismiss()
                    } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "plus")
                                .bold()
                                .foregroundStyle(.white)
                            Text(plant != nil ? "Update" : "Add")
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .clipShape(
                            .rect(cornerRadius: 10)
                        )
                    }
                    .disabled(namePlant.isEmpty)
                }
            }
            .navigationTitle(plant != nil ? "Update Plant" : "New Plant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if plant == nil {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
            .onAppear {
                if let plant = plant {
                    self.namePlant = plant.name
                }
            }
            .sheet(isPresented: $isSheetSpecy) {
                if let plant {
                    ListSpecies(plant: plant)
                }
            }
        }
    }
    
    func insertPlant() {
        let newPlant = Plant(name: namePlant)
        user.plants?.append(newPlant)
    }
    
    func updatePlant() {
        plant?.name = namePlant
    }
}

//#Preview {
//    NewPlant()
//}
