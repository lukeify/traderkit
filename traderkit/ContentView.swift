//
//  ContentView.swift
//  traderkit
//
//  Created by Luke on 11/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var importing = false
    @State private var tradeEntries: [DasCsvTradeEntry] = []
    
    var body: some View {
        VStack {
            Button("Import") {
                importing = true
            }
            .fileImporter(
                isPresented: $importing,
                allowedContentTypes: [.commaSeparatedText]
            ) { result in
                switch result {
                case .success(let file):
                    print(file.absoluteString)
                    readCsv(from: file)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .padding()
    }
    
    private func readCsv(from file: URL) {
        guard file.startAccessingSecurityScopedResource() else {
            print("Couldn't access security-scoped resource.")
            return
        }
        
        defer { file.stopAccessingSecurityScopedResource() }
        
        do {
            let data = try Data(contentsOf: file)
            guard let content = String(data: data, encoding: .utf8) else {
                print("Unable to decode CSV as UTF-8")
                return
            }
            
            tradeEntries = content
                .split(whereSeparator: \.isNewline)
                .dropFirst()
                .map(String.init)
                .map { line in
                    let parts = line
                        .split(separator: ",")
                        .map { String($0).trimmingCharacters(in: .whitespaces) }
                    
                    return DasCsvTradeEntry(time: parts[0], price: Double(parts[1]) ?? 0.0)
                }
            
            print(tradeEntries)
        } catch {
            print("Failed to read CSV file: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
