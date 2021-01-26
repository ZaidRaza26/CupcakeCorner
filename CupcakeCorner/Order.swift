//
//  Order.swift
//  CupcakeCorner
//
//  Created by Zaid Raza on 06/11/2020.
//  Copyright © 2020 Zaid Raza. All rights reserved.
//

import SwiftUI

class Order: ObservableObject {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var orders = Orderr()
    
}
