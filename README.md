# NMCustomView
NMCustomView allow users to show, on top of the actual view controller, a customized UIView (xib file). In the demo project the NMCustomView is used to show a custom alert, to zoom in on an image and to show the preview of an item in a CollectionView (using Long Press).

You can customize NMCustomView to dismiss on background tap gesture and to use blur effect.

## Screenshots

 ![Alert image](https://github.com/nmacambira/NMCustomView/blob/master/Images/NMCustomView1.png)  ![Zoom image](https://github.com/nmacambira/NMCustomView/blob/master/Images/NMCustomView2.png)  ![Preview image](https://github.com/nmacambira/NMCustomView/blob/master/Images/NMCustomView3.png)

## Usage 

1. Add "NMCustomView.swift” to your project
2. Create your custom UIView class (and xib file) that you want NMCustomView to show. Letʼs call it 'MyView'.

```swift
class MyView: UIView { 

    @IBOutlet weak var photoImageView: UIImageView!
} 
```

3. Instantiate your custom UIView (MyView) object 

```swift
class ViewController: UIViewController { 
    var customView: NMCustomView!
    var myView: MyView! 

    override func viewDidLoad() {
        super.viewDidLoad()

        myView = Bundle.main.loadNibNamed("MyView", owner: self, options: nil)?.first as! MyView
        let image = UIImage(named: "Image.jpg")
        myView.imageView.image = image

    } 
}
```

4. Instantiate a NMCustomView object and show customView

```swift 
    @IBAction func showButton(_ sender: UIButton) {

        customView = NMCustomView(showView: myView, tapOnBackgroundToDismiss: true, backgroundBlurEffect: true)
        customView.show()
    }
```

5. Dismiss customView

    Tap on background to dismiss or: 

```swift
    @IBAction func dismissButton(_ sender: UIButton) {

        customView.dismiss()
    } 
``` 

## License

[MIT License](https://github.com/nmacambira/NMCustomView/blob/master/LICENSE)

## Info

- Swift 3.1 

