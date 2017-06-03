//
//  ViewController.swift
//  NMCustomView
//
//  Created by Natalia Macambira on 01/05/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var alertViewSegment: UIView!
    @IBOutlet weak var zoomViewSegment: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var customView: NMCustomView!
    var alertView: NMAlertView!
    var zoomView: NMZoomView!
    var previewView: NMPreviewView!
    let reuseIdentifier = "item"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        zoomViewSegment.isHidden = true
        collectionView.isHidden = true
        
        createAlertView()
        createZoomView()
        
        //Longpress
        let lpgr: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showPreviewWtihLongPress(_:)))
        lpgr.minimumPressDuration = 0.3
        lpgr.delegate = self
        collectionView.addGestureRecognizer(lpgr)
    }
    
    //MARK: - Create Nibs
    func createAlertView() {
        
        alertView = Bundle.main.loadNibNamed("NMAlertView", owner: self, options: nil)?.first as! NMAlertView        
        alertView.cancelButton.addTarget(self, action: #selector(cancelButton), for: UIControlEvents.touchUpInside)
        alertView.sendButton.addTarget(self, action: #selector(sendEmail), for: UIControlEvents.touchUpInside)
    }
    
    func createZoomView() {
        
        zoomView = Bundle.main.loadNibNamed("NMZoomView", owner: self, options: nil)?.first as! NMZoomView
        let image = UIImage(named: "Image.jpg")
        zoomView.imageView.image = image
    }
    
    func createPreviewView(withBodyImage bodyImage: UIImage) {
        
        previewView = Bundle.main.loadNibNamed("NMPreviewView", owner: self, options: nil)?.first as! NMPreviewView
        previewView.bodyImageView.image = bodyImage
    }
    
    //MARK: - SegmentedControl
    
    @IBAction func segmentChangedValue(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            messageLabel.text = "Test the alerts"
            alertViewSegment.isHidden = false
            zoomViewSegment.isHidden = true
            collectionView.isHidden = true
            
        case 1:
            messageLabel.text = "Tap image to zoom"
            alertViewSegment.isHidden = true
            zoomViewSegment.isHidden = false
            collectionView.isHidden = true
            
        case 2:
            messageLabel.text = "LongPress image to preview"
            alertViewSegment.isHidden = true
            zoomViewSegment.isHidden = true
            collectionView.isHidden = false
            
        default: break
            
        }
    }
    
    //MARK: - Actions
    
    @IBAction func regularAlertButton(_ sender: UIButton) {
        
        let alert = UIAlertController.init(title: "Login", message: "Type login and password", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField: UITextField) -> Void in
            textField.placeholder = "Login"
            textField.keyboardType = .emailAddress
            textField.autocorrectionType = .no
            textField.clearButtonMode = .whileEditing
        }
        
        alert.addTextField { (textField: UITextField) -> Void in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.autocorrectionType = .no
            textField.clearButtonMode = .whileEditing
        }
        
        alert.addAction(UIAlertAction (title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction (title: "Send", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            
            print("Login: \(alert.textFields![0].text!)")
            print("Senha: \(alert.textFields![1].text!)")
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func customAlertButton(_ sender: UIButton) {
        customView = NMCustomView(showView: alertView, tapOnBackgroundToDismiss: false, blurEffect: false, blurEffectStyle: nil)
        customView.show()
    }
    
    func cancelButton() {
        customView.dismiss()
        alertView.textField.text = ""
    }
    
    func sendEmail() {
        customView.dismiss()
        let email = alertView.textField.text!
        alertView.textField.text = ""
        print("Request recoverEmail: \(email)")
    }
    
    @IBAction func zoomButton(_ sender: UIButton) {
        customView = NMCustomView(showView: zoomView, tapOnBackgroundToDismiss: true, blurEffect: true, blurEffectStyle: .dark)
        customView.show()
    }
    
    func showPreviewWtihLongPress (_ gesture: UILongPressGestureRecognizer) {
        showPreviewWtihLongPress(gesture, view: self.view, collectionView: self.collectionView)
    }
    
    func showPreviewWtihLongPress (_ gesture: UILongPressGestureRecognizer, view: UIView, collectionView: UICollectionView) {
        
        if let windowRect = view.window?.frame {
            let windowWidth = windowRect.size.width
            
            if gesture.state == UIGestureRecognizerState.began {
                
                let p: CGPoint = gesture.location(in: collectionView)
                
                if let indexPath: IndexPath = collectionView.indexPathForItem(at: p) ?? nil {
                    print("PRESSED CELL")
                    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NMCollectionViewCell {
                        
                        createPreviewView(withBodyImage: cell.bodyImageView.image!)
                        previewView.frame.size.width = windowWidth - 20
                        
                        customView = NMCustomView(showView: previewView, tapOnBackgroundToDismiss: false, blurEffect: true, blurEffectStyle: .light)
                        customView.show()
                    }
                }
                
            } else {
                print("PRESSED NIL")
            }
        }
        
        if gesture.state == UIGestureRecognizerState.ended {
            
            if customView != nil {
                customView.dismiss()
            }
        }
    }
    
    
    //MARK: - Keyboards
    func keyboardWillShow(_ notification: Notification) {
        
        if customView != nil {
            if let userInfo = notification.userInfo {
                let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
                UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                    if let keyboardHeight = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height {
                        self.customView.frame.origin.y = self.customView.frame.origin.y - keyboardHeight/2
                    }
                })
            }
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        if customView != nil {
            if let userInfo = notification.userInfo {
                let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
                UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                    if let keyboardHeight = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height {
                        self.customView.frame.origin.y = self.customView.frame.origin.y + keyboardHeight/2
                    }
                })
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NMCollectionViewCell
        let image = UIImage(named: "Image.jpg")
        cell.bodyImageView.image = image
        return cell
    }
}
