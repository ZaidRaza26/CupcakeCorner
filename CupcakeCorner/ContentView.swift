//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Zaid Raza on 05/11/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var email = ""
    
    @ObservedObject var order = Order()
    
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.orders.type){
                        ForEach(0..<Order.types.count, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.orders.quantity, in: 3...20){
                        Text("Number of cakes: \(order.orders.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orders.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.orders.specialRequestEnabled {
                        Toggle(isOn: $order.orders.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.orders.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section{
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery Details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
