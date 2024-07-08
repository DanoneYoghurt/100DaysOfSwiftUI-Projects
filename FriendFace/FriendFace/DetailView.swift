//
//  DetailView.swift
//  FriendFace
//
//  Created by Антон Баскаков on 20.06.2024.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    let user: User
    
    var body: some View {
        NavigationStack {
            List {
                Section("User Information") {
                    VStack(alignment: .leading) {
                        Text("""
                             Age: \(user.age)
                             Company: \(user.company)
                             Email: \(user.email)
                             Address: \(user.address)
                             Date joined: \(user.registered.formatted(date: .abbreviated, time: .shortened))
                             """
                        )
                        .lineSpacing(5.0)
                    }
                }
                Section("About") {
                    Text(user.about)
                }
                Section("Tags") {
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
                Section("Friends") {
                    ForEach(user.friends, id: \.id) { friend in
                        Text(friend.name)
                    }
                }
            }
            .navigationTitle(user.name)
        }
        
    }
}
//#Preview {
    //    let sampleFriend = [
    //        Friend(id: UUID(), name: "Bonita White"),
    //        Friend(id: UUID(), name: "Jack Doherty"),
    //        Friend(id: UUID(), name: "Jane Black"),
    //        Friend(id: UUID(), name: "Jim Morrison")
    //    ]
    //
    //    let sampleUser = User(id: UUID(), isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: Date.now, tags: [
    //        "cillum",
    //        "consequat",
    //        "deserunt",
    //        "nostrud",
    //        "eiusmod",
    //        "minim",
    //        "tempor"
    //    ], friends: sampleFriend)
    
//    
//    DetailView(user: user)
//        .modelContext(User.self)
//    
//}
