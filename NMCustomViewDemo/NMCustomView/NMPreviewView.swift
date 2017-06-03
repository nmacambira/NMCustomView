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
        roundCorners(view: self)
    }
 
    func roundCorners(view: UIView) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
    }
}
