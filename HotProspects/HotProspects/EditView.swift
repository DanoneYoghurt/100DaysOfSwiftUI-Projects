//
//  EditView.swift
//  HotProspects
//
//  Created by Антон Баскаков on 21.07.2024.
//

import SwiftUI

struct EditView: View {
    
    @State var prospect: Prospect
    
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
            TextField("email address", text: $prospect.emailAddress)
            
        }
    }
}

//#Preview {
//    let prospect = Prospect(name: "Vladimir Putin", emailAddress: "vlad@kremlin.ru", isContacted: false)
//    
//    
//    EditView(prospect: prospect)
//}
