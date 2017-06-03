//
//  NMCustomView.swift
//  NMCustomView
//
//  Created by Natalia Macambira on 01/05/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class NMCustomView: UIView {

    private var backgroundView: UIView!
    private var contentView = UIView()
    
    init(showView view: UIView, tapOnBackgroundToDismiss: Bool, backgroundBlurEffect: Bool) {
        super.init(frame: CGRect.zero)
        self.setupView(view, tapOnBackgroundToDismiss: tapOnBackgroundToDismiss, backgroundBlurEffect: backgroundBlurEffect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(_ view: UIView, tapOnBackgroundToDismiss: Bool, backgroundBlurEffect: Bool) {
        
        let keyWindow = UIApplication.shared.keyWindow
        let keyWindowBounds: CGRect = (keyWindow?.bounds)!
        self.frame = keyWindowBounds
        keyWindow?.addSubview(self)
        
        self.backgroundView = UIView(frame: keyWindowBounds)
        
        if backgroundBlurEffect {
            
            if !UIAccessibilityIsReduceTransparencyEnabled() {
                /* Blur effect */
                self.backgroundView.backgroundColor = UIColor.clear
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = self.backgroundView.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
        
        if tapOnBackgroundToDismiss {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NMCustomView.dismiss))
            self.backgroundView.addGestureRecognizer(tapRecognizer)
        }
        
        self.addSubview(backgroundView)
        
        self.contentView = view
        self.contentView.center = CGPoint(x: (keyWindowBounds.midX), y: (keyWindowBounds.midY))
        self.addSubview(contentView)
    }
    
    func show() {

        self.contentView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            
            self.contentView.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 1.0
            self.contentView.alpha = 1.0
            
        }) { (Bool) -> Void in
            
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
