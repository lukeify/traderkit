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
            OrdersTableView()
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
            
            for line in lines {
                let parts = line
                    .split(separator: ",")
                    .map { String($0).trimmingCharacters(in: .whitespaces) }
                
                let rec = Order(ticker: parts[0], timestamp: parts[1], price: Double(parts[2]) ?? 0.0)
                context.insert(rec)
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
