//
//  TradesTableView.swift
//  traderkit
//
//  Created by Luke on 04/07/2025.
//

import SwiftUI
import SwiftData

struct TradesTableView: View {
    @Query var trades: [Trade]
    
    var body: some View {
        Table(trades) {
            TableColumn("Ticker", value: \.ticker)
            TableColumn("Orders") { (t: Trade) in
                Text(String(t.orders.count))
            }
//            TableColumn("Time", value: \.timestamp)
//            TableColumn("Price") { (o: Order) in
//                Text(String(format: "%.2f", o.price))
//            }
        }
    }
}

#Preview {
    TradesTableView()
}
