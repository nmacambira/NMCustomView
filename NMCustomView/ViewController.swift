//
//  ViewController.swift
//  NMCustomView
//
//  Created by Natalia Macambira on 01/05/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var messageLabel: UILabel!
    
    var customView: NMCustomView!
    
    var zoomView: NMZoomView!
    
    var previewView: NMPreviewView!
    
    private let reuseIdentifier = "item"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isHidden = true
        
        createZoomView()
        
        //Longpress
        let lpgr: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showPreviewWtihLongPress(_:)))
        lpgr.minimumPressDuration = 0.3
        lpgr.delegate = self
        collectionView.addGestureRecognizer(lpgr)
        
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
    
    
    //MARK: Collection view data source
    
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
    
    
    //MARK: - Actions
    
    func showPreviewWtihLongPress (_ gesture: UILongPressGestureRecognizer) {
        
        showPreviewWtihLongPress(gesture, view: self.view, collectionView: self.collectionView)
        
    }

    @IBAction func changedValue(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            
            messageLabel.text = "Tap image to zoom"
            collectionView.isHidden = true
            
        case 1:
            
            messageLabel.text = "LongPress image to preview"
            collectionView.isHidden = false
            
        default: break
            
        }
    }
    
    @IBAction func zoomButton(_ sender: UIButton) {
        
        customView = NMCustomView(showView: zoomView, dismissOnBackgroundTap: true, backgroundBlurEffect: false)
        customView.show()
    }
    
    
    //MARK: Show Preview
    
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
                        
                        customView = NMCustomView(showView: previewView, dismissOnBackgroundTap: false, backgroundBlurEffect: true)
                        
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
    
}

