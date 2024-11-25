//
//  UsersExamples.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import Foundation

extension User {
    
    static var sampleUsers: [User] {
        [
            User(id: UUID().uuidString, name: "Simon", location: "Vietnam"),
            User(id: UUID().uuidString, name: "Layla", location: "Singapore"),
            User(id: UUID().uuidString, name: "Lizhua", location: "China"),
            User(id: UUID().uuidString, name: "ParkKing", location: "Korean"),
        ]
    }
    
}
