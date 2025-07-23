//
//  ScreenerTableView.swift
//  traderkit
//
//  Created by Luke on 23/07/2025.
//

import SwiftUI

struct ScreenerTableView: NSViewRepresentable {
    class Coordinator: NSObject, NSTableViewDelegate, NSTableViewDataSource {
        let data = ["Apple", "Banana", "Cherry"]
        
        func numberOfRows(in tableView: NSTableView) -> Int {
            print("Rows \(data.count)")
            return data.count
        }
        
        func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let cv = VerticallyCenteredTableCellView()
            cv.setLabel(data[row])
            return cv
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeNSView(context: Context) -> NSTableView {
        let tv = NSTableView()
        tv.delegate = context.coordinator
        tv.dataSource = context.coordinator
        
        tv.addTableColumn(NSTableColumn())
        
        return tv
    }
    
    func updateNSView(_ nsView: NSTableView, context: Context) {
        // TODO: Update logic here
    }
}
