//
//  Trade.swift
//  traderkit
//
//  Created by Luke on 05/07/2025.
//

import Foundation
import SwiftData

@Model final class Trade {
    var ticker: String
    @Relationship(inverse: \Order.trade) var orders: [Order]
    
    var isOpen: Bool {
        self.orders.reduce(into: 0.0) { acc, order in
            acc += order.position
        } == 0.0
    }
    
    init(ticker: String, orders: [Order]) {
        self.ticker = ticker
        self.orders = orders
    }
}
