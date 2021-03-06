//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        
        let image = getImageFromURL(from: "https://image.blockbusterbd.net/00416_main_image_04072019225805.png")
        
        let imageView = UIImageView(image: image)
        

        view.addSubview(imageView)
        self.view = view
    }
    
    func getImageFromURL(from url: String) -> UIImage? {
        let imageURL = URL(string: url)!
        let imageData = try? Data(contentsOf: imageURL)
        
        if let data = imageData {
            let image = UIImage(data: data)
            return image
        } else {
            return nil
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
