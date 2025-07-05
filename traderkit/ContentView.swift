//
//  ContentView.swift
//  traderkit
//
//  Created by Luke on 11/06/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @State private var importing = false
    
    var body: some View {
        VStack {
            Button("Import") {
                importing = true
            }
            .fileImporter(
                isPresented: $importing,
                allowedContentTypes: [.commaSeparatedText],
                onCompletion: handleImport
            )
            TradesTableView()
        }
        .padding()
    }
    
    private func handleImport(_ result: Result<URL, any Error>) {
        switch result {
        case .success(let url):
            guard url.startAccessingSecurityScopedResource() else {
                print("Couldn't access security-scoped resource.")
                return
            }
            
            defer { url.stopAccessingSecurityScopedResource() }
            
            readCsv(from: url)
        case .failure(let error):
            print("Import cancelled: \(error).")
        }
    }
    
    private func readCsv(from file: URL) {
        do {
            let data = try Data(contentsOf: file)
            guard let content = String(data: data, encoding: .utf8) else {
                print("Unable to decode CSV as UTF-8.")
                return
            }
            
            let lines = content.split(whereSeparator: \.isNewline).dropFirst().map(String.init)
            
            let trades = try lines.reduce(into: [Trade]()) { acc, line in
                let parts = line
                    .split(separator: ",")
                    .map { String($0).trimmingCharacters(in: .whitespaces) }
                
                guard let positionValue = Double(parts[2]) else {
                    throw CsvParsingError.invalidValue("Position value is invalid")
                }
                
                guard let priceValue = Double(parts[3]) else {
                    throw CsvParsingError.invalidValue("Price value is invalid")
                }
                
                // Instantiate the order object.
                let order = Order(timestamp: parts[1], position: positionValue, price: priceValue)
                
                // Iterate backwards through the accumulator to find an open trade that matches the ticker for the order.
                // Once found, associate the trade with the order
                var iter = acc.reversed().makeIterator()
                while let trade = iter.next() {
                    if trade.ticker == parts[0] && trade.isOpen {
                        trade.orders.append(order)
                        order.trade = trade
                        break
                    }
                }
                
                if order.trade == nil {
                    let trade = Trade(ticker: parts[0], orders: [])
                    order.trade = trade
                    trade.orders.append(order)
                    acc.append(trade)
                }
            }
            
            for trade in trades {
                context.insert(trade)
            }

            do {
                try context.save()
            } catch {
                print("Save failed.")
            }
            
        } catch {
            print("Failed to read CSV file: \(error).")
        }
    }
}

#Preview {
    ContentView()
}
