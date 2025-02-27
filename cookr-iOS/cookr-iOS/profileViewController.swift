//
//  profileViewController.swift
//  cookr-iOS
//
//  Created by Matin Ghaffari on 12/6/20.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class profileViewController: UIViewController, MessageInputBarDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var yy: UIView!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var Bio: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var posts = [PFObject]()
    var imageFiles = [PFFileObject]()
    let commentBar = MessageInputBar()
    
    @IBOutlet weak var updatebio: UILabel!
    
    
    let user = PFUser.current()
    
    @IBAction func hide(_ sender: Any) {
        scroll.endEditing(true)
    }
    var showsCommentBar = true

    var refreshControl: UIRefreshControl!
    var selectedPost: PFObject!
    
    //@IBOutlet weak var bb: UILabel!
    
    @IBOutlet weak var profPic: UIImageView!
 
  
    
    
    @IBOutlet weak var hi: UILabel!
    //  @IBOutlet weak var bio: UILabel!
    
    
    //  @IBOutlet weak var buttonB: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // self.hideKeyboardWhenTappedAround()
        //Bio.text = self.hi as? String
        //self.bio = bio.text
        //let comment = PFObject(className: "comment")
        //self.hi.text = comment["bio"] as? String
        commentBar.inputTextView.placeholder = "Update status..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
//        func scrollViewDidScroll(_ scrollView: scroll) {
//            view.endEditing(true)
//        }
        scroll.keyboardDismissMode = .onDrag
        
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //scroll.keyboardDismissMode()
        commentBar.inputTextView.text = nil
               
               showsCommentBar = false
               becomeFirstResponder()
               commentBar.inputTextView.resignFirstResponder()
    
    }
    
    
    
    @IBAction func onSignOut(_ sender: Any) {
        PFUser.logOutInBackground()
        
        let loginVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
        UIApplication.shared.windows.first?.rootViewController = loginVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        //let people = PFObject(className: "User")
        
    //    let imageFile = self.user?["image"] as! PFFileObject
//        if self.user?["image"] != nil {
//            let imageFile = self.user?["image"] as! PFFileObject
 //               let urlString = imageFile.url!
//        let url = URL(string: urlString)!

//            let filter = AspectScaledToFillSizeFilter(size: self.profPic.frame.size)
//            self.profPic.af.setImage(withURL: url, filter: filter)
//        }
//        else{self.user?["image"] = UIImage(named: "29")}
//
        let imageFile = user?["image"] as! PFFileObject
           let urlString = imageFile.url!
           let url = URL(string: urlString)!
       self.profPic.imageFromUrl(urlString: url.absoluteString)
        
        self.hi.text = user?["bio"] as? String
        //self.profPic = user?["image"] as! PFFileObject //self.user?["image"] as? UIImageView
      

        //let comment = (people["comment"] as? [PFObject]) ?? []
        //comment["author"] = PFUser.current()
        
        self.userName.text = PFUser.current()?.username
        //self.Bio.text = comment["bio"] as? String
      
        showsCommentBar = true
                  becomeFirstResponder()
                  commentBar.inputTextView.becomeFirstResponder()

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        
        
        //let query = PFQuery(className: "User")
        //query.includeKeys(["author", "comment", "bio"])
       // query.whereKey("objectId", equalTo: PFUser.current()?.objectId);
        

     //   var user = try query.findObjects()
     
//        let results = query.findObjectsInBackground{ (objects, error) in
//                if error == nil
//                {
//                    if let returnedobjects = objects
//                    {
//                        for query in returnedobjects
//                        {
//                            print(query)
//                            print("jljkjk")
//
//                            }
//                    }
//
//                    print(PFUser.current()?.objectId)
//                }
//            print("sdknfkdnfkjsdnfkfksdjbkldjldsbfhjlkfjldbknm")
//        }
   
//        query.findObjectsInBackground { (objects, error) in
//            if error == nil
//            {
//                if let returnedobjects = objects
//                {
//                    for query in returnedobjects
//                    {
//
//
//                        let comment = PFObject(className: "comment")
//                        let file = query["image"] as? PFFileObject
//                        //self.Bio.text = comment["bio"] as? String
//
//                        let c =  comment["bio"] as? String
//
//                        file?.getDataInBackground { (imageData: Data?, error: Error?) in
//                            if let error = error {
//                                print(error.localizedDescription)
//                            } else if let imageData = imageData {
//                                let image = UIImage(data: imageData)
//                                self.profPic.image = image
//                                self.Bio.text = c
//                            }
//                        }
//
//                        }
//                    }
//                }
//            }
    }
        
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    

    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
             //Create the comment
            //let comment = PFObject(className: "User")
        
//            comment["bio"] = text
//            comment["author"] = PFUser.current()
//
//            self.hi.text = comment["bio"] as? String
//
//
//        comment.saveInBackground { (success, error) in
        user?["bio"] = text
        user?["author"] = PFUser.current()
        
        self.hi.text = user?["bio"] as? String
  
    
        user?.saveInBackground { (success, error) in
                if success {
                    print("Comment Saved!")
                }
                
                else {
                    print("Error Saving Comment!")
                }
            }
        
        //updatebio.text = comment["bio"] as? String
            
           //self.reloadData()
            
            // Clear and dismiss the input bar
            commentBar.inputTextView.text = nil
            
            showsCommentBar = false
           becomeFirstResponder()
            commentBar.inputTextView.resignFirstResponder()
        //self.Bio.text = comment["bio"] as? String
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        
       // return self.hi.text = comment["bio"] as? String
        }
        
        @objc func keyboardWillBeHidden(note: Notification) {
            commentBar.inputTextView.text = nil
            showsCommentBar = false
            becomeFirstResponder()
        }
    
   
    @IBAction func ontapp(_ sender: Any) {
        
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
    
    @IBAction func butt(_ sender: Any) {
        
       // let people = PFObject(className: "User")
        
                let imageData = profPic.image!.pngData()
        
                let file = PFFileObject(name: "image.png", data: imageData!)
        
        self.user?["image"] = file
        
        
        user?.saveInBackground { (success, error) in
                    if success {
        
                        //self.dismiss(animated: true, completion: nil)
                        print("saved!")
                    }
                    else{
                        print("error!")
                    }
        
                }

    }
    
//
//    @IBAction func onButt(_ sender: Any) {
//        //user?["image"] = PFUser.current()
//
////        let imageData = profPic.image!.pngData()
////
////        let file = PFFileObject(name: "image.png", data: imageData!)
//        let people = PFObject(className: "User")
//
//                let imageData = profPic.image!.pngData()
//
//                let file = PFFileObject(name: "image.png", data: imageData!)
//
//        people["image"] = file
//
//
//        people.saveInBackground { (success, error) in
//                    if success {
//
//                        self.dismiss(animated: true, completion: nil)
//                        print("saved!")
//                    }
//                    else{
//                        print("error!")
//                    }
//
//                }
//
//
//
//
//
//    }
//    @IBAction func onUpdateButton(_ sender: Any) {
//
//        let people = PFObject(className: "User")
//        //people["image"]
//
//
//
//        let imageData = profPic.image!.pngData()
//
//        let file = PFFileObject(name: "image.png", data: imageData!)
//
//        people["image"] = file
//
//
//        people.saveInBackground { (success, error) in
//            if success {
//
//                //self.dismiss(animated: true, completion: nil)
//                print("saved!")
//            }
//            else{
//                print("error!")
//            }
//
//        }
//
//
//    }
    
    
    
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

//extension UIViewController {
//func hideKeyboardWhenTappedAround() {
//    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//    tap.cancelsTouchesInView = false
//    view.addGestureRecognizer(tap)
//}
//
//@objc func dismissKeyboard() {
//    view.endEditing(true)
//}
//}

