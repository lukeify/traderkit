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
    
    func makeNSView(context: Context) -> NSScrollView {
        let tv = NSTableView()
        tv.delegate = context.coordinator
        tv.dataSource = context.coordinator
        
        // Attach a header.
        tv.headerView = NSTableHeaderView()
        
        // Enables the macOS standard "look" where each row has an alternating backround color.
        tv.usesAlternatingRowBackgroundColors = true
        
        let col = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column"))
        col.title = "Fruits"
        col.resizingMask = .autoresizingMask
        
        tv.addTableColumn(col)
        
        let scrollView = NSScrollView()
        scrollView.documentView = tv
        
        return scrollView
    }
    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        // TODO: Update logic here
    }
}
