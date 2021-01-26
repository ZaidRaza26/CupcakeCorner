//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Zaid Raza on 09/11/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.orders.name)
                
                TextField("Street Address", text: $order.orders.streetAddress)
                
                TextField("City", text: $order.orders.city)
                
                TextField("Zip", text: $order.orders.zip)
            }
            
            Section{
                NavigationLink(destination: CheckoutView(order: order)){
                    Text("Checkout")
                }
            }
            .disabled(order.orders.hasValidAddress == false || order.orders.hasSpaces == false)
        }
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}
