//
//  ContentView.swift
//  Moonshot
//
//  Created by Антон Баскаков on 22.05.2024.
//

import SwiftUI


let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
let missions: [Mission] = Bundle.main.decode("missions.json")

let columns = [
    GridItem(.adaptive(minimum: 150))
]

struct GridLayout: View {
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                    )
                }
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
            }
            
            
        }
        
        .padding([.horizontal, .bottom])
    }
}

struct ListLayout: View {
    var body: some View {
        LazyVStack {

            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                    )
                    .padding(.horizontal)
                }
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
            }
            
        }
    }
}

struct ContentView: View {
    
    @State private var showingGrid = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if showingGrid {
                        GridLayout()
                    } else {
                        ListLayout()
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        Image(systemName: showingGrid ? "rectangle.grid.1x2" : "rectangle.grid.2x2")
                            .foregroundStyle(.white)
                            .accessibilityLabel(showingGrid ? "Show list view" : "rectangle.grid.2x2")
                    }
                }
            }
        }
        
    }
    
}

#Preview {
    ContentView()
}
