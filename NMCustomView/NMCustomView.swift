//
//  NMCustomView.swift
//  NMCustomView
//
//  Created by Natalia Macambira on 01/05/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class NMCustomView: UIView {

    var backgroundView: UIView!
    var contentView = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(showView view: UIView, dismissOnBackgroundTap: Bool, backgroundBlurEffect: Bool) {
        
        super.init(frame: CGRect.zero)
        
        self.setupView(view, dismissOnBackgroundTap: dismissOnBackgroundTap, backgroundBlurEffect: backgroundBlurEffect)
        
    }
    
    fileprivate func setupView(_ view: UIView, dismissOnBackgroundTap: Bool, backgroundBlurEffect: Bool) {
        
        let keyWindow = UIApplication.shared.keyWindow
        let keyWindowBounds = keyWindow?.bounds as CGRect!
        self.frame = keyWindowBounds!
        
        self.backgroundView = UIView(frame: keyWindowBounds!)
        
        if backgroundBlurEffect {
            
            if !UIAccessibilityIsReduceTransparencyEnabled() {
                self.backgroundView.backgroundColor = UIColor.clear
                
                /* Bluer effect */
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = self.backgroundView.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
                self.backgroundView.addSubview(blurEffectView)
                
            } else {
                
                /* Dark backgroung */
                self.backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
                self.backgroundView.alpha = 0
                
            }
        } else {
            
            /* Dark backgroung */
            self.backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
            self.backgroundView.alpha = 0
        }
        
        self.addSubview(backgroundView)
        
        self.contentView = view
        self.contentView.center = CGPoint(x: (keyWindowBounds?.midX)!, y: (keyWindowBounds?.midY)!)
        self.addSubview(contentView)
        
        if dismissOnBackgroundTap {
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NMCustomView.dismiss))
            self.backgroundView.addGestureRecognizer(tapRecognizer)
        }
        
    }
    
    func show() {
        
        let keyWindow = UIApplication.shared.keyWindow
        
        keyWindow?.addSubview(self)
        
        self.contentView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            
            self.contentView.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 1.0
            self.contentView.alpha = 1.0
            
        }) { (Bool) -> Void in
            
        }
        
        if let center: CGPoint = keyWindow?.center {
            self.contentView.center = center
        }
    }
    
    func dismiss() {
        
        self.endEditing(true)
        
        self.contentView.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            
            self.contentView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.backgroundView.alpha = 0
            self.contentView.alpha = 0
            
        }) { (Bool) -> Void in
            self.removeFromSuperview()
        }
    }
}
