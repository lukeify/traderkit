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
    @Published var connectionEstablished: Bool = false
    
    func initializeGrpcClient() async {
        let transport = try! HTTP2ClientTransport.Posix(
            target: .ipv4(host: "127.0.0.1", port: 8080),
            transportSecurity: .plaintext
        )
        
        let client = GRPCClient(transport: transport)
        self.client = client
        
        Task {
            do {
                await MainActor.run {
                    self.connectionEstablished = true
                }
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
    
    func healthChecks() -> HealthCheckService {
        guard let client = self.client else {
            fatalError("Client not instantiated")
        }
        return HealthCheckService(client: client)
    }
    
    func screeners() -> ScreenerService {
        guard let client = self.client else {
            fatalError("Client not instantiated")
        }
        return ScreenerService(client: client)
    }
}
