//
//  NewSpecies.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//


import SwiftData
import SwiftUI

struct NewSpecies: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var nameSpecy: String = ""
    @State private var color = Color.red
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent("Name") {
                    TextField("", text: $nameSpecy, prompt: Text("Name"))
                }
                
                ColorPicker("Set the species color", selection: $color, supportsOpacity: false)
                
                Button("Create new specy") {
                    let newSpecy = Species(name: nameSpecy, color: color.toHexString()!)
                    modelContext.insert(newSpecy)
                    dismiss()
                }
            }
            .navigationTitle("New Species")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
