//
//  RecipeViewController.swift
//  cookr-iOS
//
//  Created by Pushpak Patel on 12/8/20.
//

import UIKit
import Parse
import AlamofireImage

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var scrollie: UIScrollView!
    
    override class func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
        true
    }
    
    var post: PFObject?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        let contentWidth = scrollie.bounds.width
        let contentHeight = scrollie.bounds.height * 3
        scrollie.contentSize = CGSize(width: contentWidth, height: contentHeight)

        let subviewHeight = CGFloat(120)
        var currentViewOffset = CGFloat(0);

        while currentViewOffset < contentHeight {
//            let frame = CGRectMake(0, currentViewOffset, contentWidth, subviewHeight).rectByInsetting(dx: 5, dy: 5)
//            let hue = currentViewOffset/contentHeight
////            let subview = UIView(frame: frame)
//            subview.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
//            scrollie.addSubview(subview)

            currentViewOffset += subviewHeight
        }
        
//        scrollie = UIScrollView(frame: view.bounds)
//           scrollie.backgroundColor = UIColor.blackColor()
//           scrollie.contentSize = imageView.bounds.size
//           scrollie.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
//               
//           scrollie.addSubview(imageView)
//           view.addSubview(scrollView)
        
//        let contentWidth = scrollie.bounds.width
//                let contentHeight = scrollie.bounds.height * 3
//                scrollie.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .white
        
        titleLabel.text = post?["title"] as? String
        ingredientsLabel.text = post?["ingredient"] as? String
        stepLabel.text = post?["step"] as? String
        
        let imageFile = post?["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        let filter = AspectScaledToFillSizeFilter(size: recipeImage.frame.size)
        recipeImage.af.setImage(withURL: url, filter: filter)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
