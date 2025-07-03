//
//  DasCsvTradeEntry.swift
//  traderkit
//
//  Created by Luke on 02/07/2025.
//

import Foundation

struct DasCsvTradeEntry {
    let time: String
    let price: Double

    init(time: String, price: Double) {
        self.time = time
        self.price = price
    }
}
