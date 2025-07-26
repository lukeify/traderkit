//
//  TraderkitApi.swift
//  traderkit
//
//  Created by Luke on 24/07/2025.
//
import SwiftUI
import GRPCCore
import GRPCNIOTransportHTTP2

final class TraderkitApi: ObservableObject {
    private var client: GRPCClient<HTTP2ClientTransport.Posix>?
    
    func initializeGrpcClient() async {
        let transport = try! HTTP2ClientTransport.Posix(
            target: .ipv4(host: "127.0.0.1", port: 8080),
            transportSecurity: .plaintext
        )
        
        let client = GRPCClient(transport: transport)
        self.client = client
        
        Task {
            do {
                try await client.runConnections()
            } catch {
                print("gRPC runConnections() exited with error: \(error)")
            }
        }
    }
    
    func shutdownGrpcClient() {
        if let client = self.client {
            client.beginGracefulShutdown()
        }
    }
    
    func screeners() -> ScreenerService {
        return ScreenerService(client: self.client!)
    }
}
