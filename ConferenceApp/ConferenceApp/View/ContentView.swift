//
//  ContentView.swift
//  ConferenceApp
//
//  Created by Антон Баскаков on 13.07.2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var showAddView = false
    
    var viewModel = ViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if viewModel.model.persons.isEmpty {
                    ContentUnavailableView {
                        Label("No people", systemImage: "photo.badge.plus")
                    } description: {
                        Text("Tap here to add a person")
                    } actions: {
                        Button("Add a person") {
                            showAddView.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(viewModel.model.persons) { item in
                            NavigationLink {
                                DetailView(photo: viewModel.convertDataToImage(item.photo), description: item.description)
                            } label: {
                                HStack {
                                    viewModel.convertDataToImage(item.photo)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .padding(.vertical, 5)
                                    
                                    Spacer()
                                    
                                    Text(item.description)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .onDelete(perform: viewModel.removeItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            EditButton()
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Add a person", systemImage: "plus") {
                                showAddView.toggle()
                            }
                        }
                    }
                }
            }
            .navigationTitle("People Tracker")
            .sheet(isPresented: $showAddView) {
                AddView(model: viewModel.model)
            }
        }
    }
}

#Preview {
    ContentView()
}

