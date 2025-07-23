//
//  ContentView.swift
//  traderkit
//
//  Created by Luke on 11/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: String?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                NavigationLink("Scanner", value: "scanner")
                NavigationLink("Journal", value: "journal")
            }
        } detail: {
            if selection == "scanner" {
                VStack {
                    ScreenerTableView()
                    Spacer()
                }
                // Scanner criteria:
                // Current price +- 2% from previous day close
                // Premarket shares traded > 50,000
                // Price > 1
                // Average True Range % > ???
                // Short Interest < 30%
                
                // Sort by:
                // Volume
                // RVol (
            } else if selection == "journal" {
                Text("Goodbye!")
            } else {
                Text("Select an item from the list")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
