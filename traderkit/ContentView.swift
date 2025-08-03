//
//  ContentView.swift
//  traderkit
//
//  Created by Luke on 11/06/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var api: TraderkitApi
    @State var isOk: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            if !api.connectionEstablished {
                Text("Starting server...")
            } else {
                isOk ? Text("Success!") : Text("Failure!")
            }
        }
        .padding()
        .onChange(of: api.connectionEstablished) {
            Task {
                if api.connectionEstablished == true {
                    await monitorServerHealth()
                }
            }
        }
    }
    
    func monitorServerHealth() async {
        let response = await api.healthChecks().monitor()
        for await res in response {
            await MainActor.run {
                self.isOk = res.ok
            }
        }
    }
}

#Preview {
    ContentView()
}
