//
//  Order.swift
//  traderkit
//
//  Created by Luke on 04/07/2025.
//

import Foundation
import SwiftData

@Model final class Order {
    var timestamp: String
    var price: Double
    var position: Double
    @Relationship var trade: Trade
    
    init(timestamp: String, position: Double, price: Double, trade: Trade) {
        self.timestamp = timestamp
        self.price = price
        self.position = position
        self.trade = trade
    }
}
