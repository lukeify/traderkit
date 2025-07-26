//
//  traderkitApp.swift
//  traderkit
//
//  Created by Luke on 11/06/2025.
//

import SwiftUI
import Foundation

@main
struct traderkitApp: App {
    @StateObject var api = TraderkitApi()
    
    var body: some Scene {
        WindowGroup {
            ContentView().task {
                await api.initializeGrpcClient()
                try! await api.screeners().preview()
            }.onReceive(NotificationCenter.default.publisher(for: NSApplication.willTerminateNotification)) { _ in
                api.shutdownGrpcClient()
            }
        }
    }
}
