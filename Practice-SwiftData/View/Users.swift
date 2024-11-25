//
//  Users.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import SwiftUI
import SwiftData

struct Users: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    
    init(
        sortOrder: SortOrder
    ) {
        
        let sortDesciptor: [SortDescriptor<User>]
        
        switch sortOrder {
        case .name:
            sortDesciptor = [SortDescriptor(\User.name)]
        case .location:
            sortDesciptor = [SortDescriptor(\User.location)]
        }
        
        _users = Query(sort: sortDesciptor)
    }
    
    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink {
                    NewUser(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .bold()
                        Text(user.location)
                    }
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let user = users[index]
                    modelContext.delete(user)
                }
            }
        }
    }
}
