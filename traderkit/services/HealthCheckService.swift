//
//  HealthCheckService.swift
//  traderkit
//
//  Created by Luke on 03/08/2025.
//
import SwiftProtobuf
import GRPCCore
import GRPCNIOTransportHTTP2

class HealthCheckService {
    let client: GRPCClient<HTTP2ClientTransport.Posix>
    
    init(client: GRPCClient<HTTP2ClientTransport.Posix>) {
        self.client = client
    }
    
    public func monitor() async -> AsyncStream<Traderkit_HealthCheckMonitorResponse> {
        AsyncStream { continuation in
            Task {
                let healthChecks = Traderkit_HealthChecks.Client(wrapping: self.client)
                do {
                    try await healthChecks.monitor(Google_Protobuf_Empty()) { res in
                        for try await message in res.messages {
                            continuation.yield(message)
                        }
                    }
                    continuation.finish()
                } catch {
                    var res = Traderkit_HealthCheckMonitorResponse()
                    res.ok = false
                    continuation.yield(res)
                    continuation.finish()
                }
            }
        }
    }
}
