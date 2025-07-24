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
    private var grpcManager: GRPCClientManager?
    
    class GRPCClientManager {
        static private(set) var client: GRPCClient<HTTP2ClientTransport.Posix>?
        
        static func initialize() async throws {
            try await withGRPCClient(
                transport: .http2NIOPosix(
                    target: .ipv4(host: "docker.host.internal"),
                    transportSecurity: .plaintext
                )
            ) { client in
                self.client = client
            }
        }
    }
    
    func initialize() async throws {
        try await GRPCClientManager.initialize()
    }
}
