//
//  NMButton.swift
//  NMCustomView
//
//  Created by Natalia Macambira on 03/06/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class NMButton: UIButton {
        
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
            } else {
                self.backgroundColor = UIColor.white
            }
        }
    }
}
