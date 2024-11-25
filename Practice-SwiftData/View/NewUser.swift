//
//  NewUser.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import SwiftData
import SwiftUI

struct NewUser: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var location: String = ""
    @Query(sort: \Plant.name) var plants: [Plant]
    
    @State private var isAddPlant: Bool = false
    var isChange: Bool {
        return userEdit?.name != name || userEdit?.location != location
    }
    
    let userEdit: User?
    
    init(user: User? = nil) {
        self.userEdit = user
    }
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent("Name") {
                    TextField("", text: $name, prompt: Text("Name"))
                }
                
                LabeledContent("Name") {
                    TextField("", text: $location, prompt: Text("Location"))
                }
                
                Text("Plants")
                
                List {
                    if let plants = userEdit?.plants {
                        ForEach(plants) { plant in
                            VStack {
                                NavigationLink {
                                    if let userEdit {
                                        NewPlant(
                                            user: userEdit,
                                            plant: plant
                                        )
                                    }
                                } label: {
                                    Text(plant.name)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let plant = plants[index]
                                modelContext.delete(plant)
                            }
                        }
                    }
                }
                Button {
                    isAddPlant.toggle()
                } label: {
                    Text("New Plant")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .clipShape(
                            .rect(cornerRadius: 10)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
//                VStack(alignment: .leading,spacing: 10) {
//                    Text("Plants")
//                    List {
//                        if let plants = userEdit?.plants {
//                            ForEach(plants) { plant in
//                                VStack {
//                                    NavigationLink {
//                                        if let userEdit {
//                                            NewPlant(
//                                                user: userEdit,
//                                                plant: plant
//                                            )
//                                        }
//                                    } label: {
//                                        Text(plant.name)
//                                    }
//                                }
//                            }
//                            .onDelete { indexSet in
//                                indexSet.forEach { index in
//                                    let plant = plants[index]
//                                    modelContext.delete(plant)
//                                }
//                            }
//                        }
//                    }
//                    Button {
//                        isAddPlant.toggle()
//                    } label: {
//                        Text("New Plant")
//                            .foregroundStyle(.white)
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 8)
//                            .background(Color.green)
//                            .clipShape(
//                                .rect(cornerRadius: 10)
//                            )
//                    }
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                }
                
                Button {
                    if userEdit != nil {
                        updateUser()
                    } else {
                        insertUser()
                    }
                    
                    dismiss()
                } label: {
                    Text(userEdit != nil ? "Update User" : "Add new user")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .foregroundStyle(.white)
                        .background((name.isEmpty || !isChange) ? .gray : .blue)
                        .clipShape(
                            .rect(cornerRadius: 10)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .disabled(name.isEmpty || !isChange)
            }
            .navigationTitle(userEdit != nil ? "Update User" : "New User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if userEdit == nil {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
            .onAppear {
                if let user = userEdit {
                    name = user.name
                    location = user.location
                }
            }
            .sheet(isPresented: $isAddPlant) {
                if let userEdit {
                    NewPlant(user: userEdit, plant: nil)
                }
            }
        }
    }
    
    func insertUser() {
        var user: User
        if location != "" {
            user = User(name: name, location: location)
        } else {
            user = User(name: name)
        }
        modelContext.insert(user)
    }
    
    func updateUser() {
        if userEdit?.name != name {
            userEdit?.name = name
        }
        if userEdit?.location != location {
            userEdit?.location = location
        }
    }
}
