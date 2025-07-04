//
//  Trade.swift
//  traderkit
//
//  Created by Luke on 04/07/2025.
//

import Foundation
import SwiftData

@Model final class Trade {
    var ticker: String
    var timestamp: String
    var price: Double
    
    init(ticker: String, timestamp: String, price: Double) {
        self.ticker = ticker
        self.timestamp = timestamp
        self.price = price
    }
}
