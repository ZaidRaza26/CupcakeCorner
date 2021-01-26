//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Zaid Raza on 09/11/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var confirmationMessage = ""
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @State private var showingAlert = false
    @State private var showingConfirmation = false
    
    @ObservedObject var order = Order()
    
    var body: some View {
        
        GeometryReader{ geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibilityElement(children: .ignore)
                    Text("Your total is $\(self.order.orders.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: self.$showingConfirmation) {
            Alert(title: Text(alertTitle), message: Text(self.confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.orders) else{
            print("encoding failed")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else{
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error").")
                self.confirmationMessage = error?.localizedDescription ?? "Unknown Error"
                self.alertTitle = "Error"
                self.showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Orderr.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.alertTitle = "Thank you!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

