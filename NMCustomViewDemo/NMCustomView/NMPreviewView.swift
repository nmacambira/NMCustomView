//
//  NMPreviewView.swift
//  NMCustomView
//
//  Created by Natalia Macambira on 01/05/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class NMPreviewView: UIView {
    
    @IBOutlet weak var bodyImageView: UIImageView!
    
    override func draw(_ rect: CGRect) {
        
        roundViewBorders(self)
    }
 
    func roundViewBorders(_ view: UIView) {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
    }
}
