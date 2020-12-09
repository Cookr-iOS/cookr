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
    
    var post: PFObject?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
