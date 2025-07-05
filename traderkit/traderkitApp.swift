//
//  traderkitApp.swift
//  traderkit
//
//  Created by Luke on 11/06/2025.
//

import SwiftUI
import SwiftData

@main
struct traderkitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(for: [Trade.self, Order.self])
        }
    }
}
