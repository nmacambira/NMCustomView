# NMCustomView
NMCustomView allow users to show, on top of the actual view controller, a customized UIView (xib file). In the project the NMCustomView is used to zoom in on an image and to show the preview of an item in a CollectionView (using Long Press). You can also use NMCustomView to show your custom alert, for 
example.

You can customize NMCustomView to dismiss on background tap gesture and to use blur effect.

## Screenshots

|![Zoom select](url)|![Zoom image](url)|

|![Preview select](url)|![Preview image] (url)| 

## Usage 

1. Add "NMCustomView.swift” to your project
2. Create your custom UIView class (and xib file) that you want NMCustomView to show. Letʼs call it 'MyView'.

```swift
class MyView: UIView { 

    @IBOutlet weak var photoImageView: UIImageView!

} 
```

3. Instantiate a NMCustomView object
4. Instantiate your custom UIView (MyView) object 

```swift
class ViewController: UIViewController { 
    var customView: NMCustomView!
    var myView: MyView! 

    override func viewDidLoad() {
        super.viewDidLoad()

        myView = Bundle.main.loadNibNamed("MyView", owner: self, options: nil)?.first as! MyView

        let image = UIImage(named: "Image.jpg")
        myView.imageView.image = image

        customView = NMCustomView(showView: myView, dismissOnBackgroundTap: true, backgroundBlurEffect: true)
    } 
}
```

5. Show customView

```swift 
    @IBAction func showButton(_ sender: UIButton) {
        customView.show()
}
```

6. Dismiss customView

Tap on background to dismiss or: 

```swift

    @IBAction func dismissButton(_ sender: UIButton) { 
        customView.dismiss() } 
``` 

## License

[MIT License](url)

## Info

- Swift 3.1 

