//
//  Plant.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import Foundation
import SwiftData

@Model
class Plant {
    var id: String
    var name: String
    var createDate: Date = Date.now
    @Relationship(inverse: \Species.plants)
    var species: [Species]?
    
    init(
        id: String = UUID().uuidString,
        name: String
    ) {
        self.id = id
        self.name = name
    }
    
    var userOwner: User?
}
