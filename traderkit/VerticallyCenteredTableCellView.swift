//
//  VerticallyCenteredTableCellView.swift
//  traderkit
//
//  Created by Luke on 23/07/2025.
//

import AppKit

class VerticallyCenteredTableCellView: NSTableCellView {
    let centeredTextField = NSTextField(labelWithString: "")
    
    // Programmatic view creation
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    // Interface Builder creation
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setLabel(_ label: String) {
        centeredTextField.stringValue = label
    }
    
    private func setup() {
        centeredTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(centeredTextField)
        self.textField = centeredTextField
        
        NSLayoutConstraint.activate([
            centeredTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            centeredTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            centeredTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
