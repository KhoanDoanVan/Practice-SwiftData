//
//  Practice_SwiftDataApp.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import SwiftUI
import SwiftData

@main
struct Practice_SwiftDataApp: App {
    
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
    
    init() {
        let schema = Schema([User.self])
        let config = ModelConfiguration("MyPlants", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Error Config Container SwiftData")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}

