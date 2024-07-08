//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Антон Баскаков on 06.06.2024.
//

import SwiftUI

struct AddressView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        
        Form {
            Section {
                TextField("Name", text: $order.name)
                    .onChange(of: order.name) {
                        UserDefaults.standard.setValue(order.name, forKey: "Name")
                    }
                TextField("Street address", text: $order.streetAddress)
                    .onChange(of: order.streetAddress) {
                        UserDefaults.standard.setValue(order.streetAddress, forKey: "Street Address")
                    }
                TextField("City", text: $order.city)
                    .onChange(of: order.city) {
                        UserDefaults.standard.setValue(order.name, forKey: "City")
                    }
                TextField("ZIP", text: $order.zip)
                    .onChange(of: order.zip) {
                        UserDefaults.standard.setValue(order.name, forKey: "ZIP")
                    }
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    AddressView(order: Order())
}
