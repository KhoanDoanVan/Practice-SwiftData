//
//  ListSpecies.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import SwiftUI
import SwiftData

struct ListSpecies: View {
    
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Species.name) private var species: [Species]
    @State private var isNewSpecies: Bool = false
    
    let plant: Plant
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(species) { specy in
                        HStack {
                            if let listSpecies = plant.species,
                               listSpecies.contains(where: {
                                $0.id == specy.id
                            })
                            {
                                Image(systemName: "circle.inset.filled")
                                    .foregroundStyle(specy.hexColor)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundStyle(specy.hexColor)
                            }
                            Text(specy.name)
                                
                        }
                        .onTapGesture {
                            withAnimation {
                                actionSpecies(specy)
                            }
                        }
                    }
                }
                
                Button("Add New") {
                    isNewSpecies.toggle()
                }
            }
            .navigationTitle("List Species")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $isNewSpecies) {
                NewSpecies()
            }
        }
    }
    
    func actionSpecies(_ specy: Species) {
        if let species = plant.species {
            if species.contains(where: { $0.id == specy.id }) {
                let index = species.firstIndex(where: { $0.id == specy.id }) ?? 0
                plant.species?.remove(at: index)
            } else {
                plant.species?.append(specy)
            }
        }
    }
}

//#Preview {
//    NewSpecies()
//}
