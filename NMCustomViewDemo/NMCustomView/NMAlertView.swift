//
//  NMAlertView.swift
//  NMCustomView
//
//  Created by Natalia Macambira on 03/06/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class NMAlertView: UIView {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: NMButton!
    @IBOutlet weak var cancelButton: NMButton!

    override func draw(_ rect: CGRect) {
        textFieldConfig(textField)
        roundCorners(view: self)
    }
    
    func textFieldConfig(_ textField: UITextField) {
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
    }
    
    func roundCorners(view: UIView) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 13
    }
}
