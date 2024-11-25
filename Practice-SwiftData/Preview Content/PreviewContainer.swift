//
//  PreviewContainer.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create preview content")
        }
    }
    
    func addExamples(_ examples: [any PersistentModel]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
