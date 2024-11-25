//
//  Species.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import SwiftData
import SwiftUI

@Model
class Species {
    var id: String
    var name: String
    var color: String
    var plants: [Plant]?
    
    init(
        id: String = UUID().uuidString,
        name: String,
        color: String
    ) {
        self.id = id
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
