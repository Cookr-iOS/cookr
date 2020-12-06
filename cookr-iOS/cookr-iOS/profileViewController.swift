//
//  profileViewController.swift
//  cookr-iOS
//
//  Created by Matin Ghaffari on 12/6/20.
//

import UIKit
import Parse
import AlamofireImage

class profileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    var posts = [PFObject]()
    var imageFiles = [PFFileObject]()

     var refreshControl: UIRefreshControl!
     var selectedPost: PFObject!
    
   @IBOutlet weak var profPic: UIImageView!
 
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
 
//                (objects: [PFObject]?, error: NSError?) -> Void in

        let people = PFObject(className: "people")
//        let hi = PFFileObject(name: "image.png", data: people as! Data)
        let imageFile = people["image.png"] as! PFFileObject
        
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        profPic.imageFromUrl(urlString: url.absoluteString)

        
        
//        let imageFile = profileViewController.getPFFileFromImage(image: people["image"] as? UIImage)
//        let urlString = (imageFile?.url!)!
//        let url = URL(string: urlString)!
//        profPic.imageFromUrl(urlString: url.absoluteString)
//        imageFile.getDataInBackground { (imageData: Data?, error: Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let imageData = imageData {
//                let image = UIImage(data: imageData)
//                self.profPic.image = image
//            }
        }
//        //let imageFile = people["image"] as! PFFileObject
//        let imageFile = people.objectId?.appending("image") as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//
//               //print(url)
    
         
    

//    override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//
//            let query = PFQuery(className: "Posts")
//        query.includeKeys(["image"])
////            query.findObjectsInBackground { (posts, error) in
////                if posts != nil {
////                    self.profPic =  UIImage(data: posts)
////                    self.profPic.image = image
////                }
////            }
//        }
//
//
        // Do any additional setup after loading the view.
  //  }
//    override func viewDidAppear(_ animated: Bool) {
//         super.viewDidAppear(animated)
//         self.shit()
//     }
//
//    @objc func shit() {
//
//        let query = PFQuery(className:"people")
//
//
//        let imageFile  = query.includeKey("image") as! PFFileObject
//                let urlString = imageFile.url!
//                let url = URL(string: urlString)!

//
//        let people = PFObject(className: "people")
//        let imageFile = people["imageFile"] as! PFFileObject

    
//

   // }
//    let people = PFQuery(className: "people")
//
// let imageFile = people.includeKey("image") as! PFFileObject//["image"] as! PFFileObject
//     let urlString = imageFile.url!
//     let url = URL(string: urlString)!
//
//            //print(url)
//     profPic.imageFromUrl(urlString: url.absoluteString)
   


    @IBAction func tapPic(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
            
  
        
        }
        
        present(picker, animated: true, completion: nil)
        
    
    }
    

    @IBAction func onUpdateButton(_ sender: Any) {
        
        let people = PFObject(className: "people")

        
        
        let imageData = profPic.image!.pngData()
        
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        people["image"] = file
        
        
        people.saveInBackground { (success, error) in
            if success {
      
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }
            else{
                print("error!")
            }
            
        }
    

    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        profPic.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse?, data: Data?, error: Error?) -> Void in
                if let data = data as Data? {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}

