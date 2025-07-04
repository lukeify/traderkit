//
//  TradesTableView.swift
//  traderkit
//
//  Created by Luke on 04/07/2025.
//

import SwiftUI
import SwiftData

struct OrdersTableView: View {
    @Query var orders: [Order]
    
    var body: some View {
        Table(orders) {
            TableColumn("Ticker", value: \.ticker)
            TableColumn("Time", value: \.timestamp)
            TableColumn("Price") { (o: Order) in
                Text(String(format: "%.2f", o.price))
            }
        }
    }
}

#Preview {
    OrdersTableView()
}
