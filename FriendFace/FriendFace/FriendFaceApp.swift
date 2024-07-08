//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Антон Баскаков on 20.06.2024.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
