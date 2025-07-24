//
//  traderkitApp.swift
//  traderkit
//
//  Created by Luke on 11/06/2025.
//

import SwiftUI

@main
struct traderkitApp: App {
    @StateObject var api = TraderkitApi()
    
    var body: some Scene {
        WindowGroup {
            ContentView().task {
                do {
                    try await api.initialize()
                } catch {
                    print("Failed to initialize!")
                }
            }
        }
    }
}
