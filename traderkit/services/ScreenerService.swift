//
//  ScreenerService.swift
//  traderkit
//
//  Created by Luke on 24/07/2025.
//
import GRPCCore
import GRPCNIOTransportHTTP2

class ScreenerService {
    let client: GRPCClient<HTTP2ClientTransport.Posix>
    
    init(client: GRPCClient<HTTP2ClientTransport.Posix>) {
        self.client = client
    }
    
    public func preview() async throws -> Traderkit_ScreenerPreviewResponse {
        let screener = Traderkit_Screener.Client(wrapping: self.client)
        
        let previewReq = Traderkit_ScreenerFiltersRequest.with {
            $0.filters = []
        }
        
        return try await screener.preview(previewReq)
    }
}
