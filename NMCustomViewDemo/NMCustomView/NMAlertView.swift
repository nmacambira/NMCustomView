//
//  NMCustomAlert.swift
//  NMCustomView
//
//  Created by Natalia Macambira on 03/06/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class NMCustomAlert: UIView {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!

    
    override func draw(_ rect: CGRect) {
        
        roundCorners(view: self)
    }
    
    func roundCorners(view: UIView) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 13
    }
}
