//
//  ContentView.swift
//  FriendFace
//
//  Created by Антон Баскаков on 20.06.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @Query(sort: \User.name) var users: [User]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        HStack {
                            Image(systemName: user.isActive ? "circle.fill" : "circle")
                                .foregroundStyle(user.isActive ? .green : .primary)
                                .font(.system(size: 8))
                            Text(user.name)
                        }
                        
                    }
                }
            }
            .navigationTitle("Users")
        }
        .alert("Error", isPresented: $showingAlert, actions: {
            Text(errorMessage)
        })
        
        .task {
            do {
                try? modelContext.delete(model: User.self)
                try await loadData()
            } catch {
                errorMessage = "Error \(error.localizedDescription)"
                showingAlert = true
            }
        }
    }
    func loadData() async throws {
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            throw NetworkError.invalidURL
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let users = try decoder.decode([User].self, from: data)
            
            users.forEach { modelContext.insert($0) }
        } catch {
            throw NetworkError.decodingError
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case loadingError
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
