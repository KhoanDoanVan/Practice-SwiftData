//
//  User.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import Foundation
import SwiftData

@Model
class User {
    var id: String
    var name: String
    var location: String
    @Relationship(deleteRule: .cascade)
    var plants: [Plant]?
    
    init(
        id: String = UUID().uuidString,
        name: String,
        location: String = ""
    ) {
        self.id = id
        self.name = name
        self.location = location
    }
}
