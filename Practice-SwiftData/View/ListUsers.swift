//
//  ListUsers.swift
//  Practice-SwiftData
//
//  Created by Đoàn Văn Khoan on 25/11/24.
//

import SwiftUI
import SwiftData

enum SortOrder: String, CaseIterable, Identifiable {
    case name, location
    
    var id: Self {
        self
    }
}

struct ListUsers: View {
    
    @Query(sort: \User.name) var users: [User]
    @State private var isOpenNewUser: Bool = false
    @State private var sortBy: SortOrder = SortOrder.name
    
    var body: some View {
        NavigationStack {
            VStack {
                Users(sortOrder: sortBy)
            }
            .navigationTitle("List Users")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Picker("", selection: $sortBy) {
                        ForEach(SortOrder.allCases) { sortOrder in
                            Text("Sort by: \(sortOrder.rawValue)")
                                .tag(sortOrder)
                        }
                    }
                    .buttonStyle(.plain)
                    .background(.blue)
                    .bold()
                    .tint(.white)
                    .clipShape(
                        .rect(cornerRadius: 10)
                    )
                    .shadow(color: .gray, radius: 2, x: 0, y: 4)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isOpenNewUser.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .padding(5)
                            .foregroundStyle(.white)
                            .background(.green)
                            .clipShape(Circle())
                            .shadow(color: .gray, radius: 2, x: 0, y: 4)
                    }
                }
            }
            .sheet(isPresented: $isOpenNewUser) {
                NewUser(user: nil)
            }
        }
    }
}

#Preview {
    
    let preview = Preview(User.self)
    let users = User.sampleUsers
    preview.addExamples(users)
    
    return NavigationStack {
        ListUsers()
            .modelContainer(preview.container)
    }
}
