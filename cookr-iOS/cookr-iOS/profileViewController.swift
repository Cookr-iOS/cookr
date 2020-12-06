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

    
    @IBOutlet weak var Bio: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var posts = [PFObject]()
    var imageFiles = [PFFileObject]()
    let commentBar = MessageInputBar()
    
    @IBOutlet weak var updatebio: UILabel!
    
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
        //Bio.text = self.hi as? String
        //self.bio = bio.text
        //let comment = PFObject(className: "comment")
        //self.hi.text = comment["bio"] as? String
        commentBar.inputTextView.placeholder = "Update Bio..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
    
    
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let people = PFObject(className: "User")
        let comment = PFObject(className: "comment")

        //let comment = (people["comment"] as? [PFObject]) ?? []
        //comment["author"] = PFUser.current()
        
        self.userName.text = PFUser.current()?.username
        //self.Bio.text = comment["bio"] as? String
      
        
        
        let query = PFQuery(className: "User")
        query.includeKeys(["author", "comment", "bio"])
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if let returnedobjects = objects
                {
                    for query in returnedobjects
                    {

                        let file = query["image"] as? PFFileObject
                        //self.Bio.text = comment["bio"] as? String
                      

                        
                        file?.getDataInBackground { (imageData: Data?, error: Error?) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else if let imageData = imageData {
                                let image = UIImage(data: imageData)
                                self.profPic.image = image
                                self.Bio.text = query["bio"] as? String
                            }
                        }



                        }
                    }
                }
            }
    }
        
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    

    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
             //Create the comment
            let comment = PFObject(className: "comment")
            comment["bio"] = text
            comment["author"] = PFUser.current()
            
            self.hi.text = comment["bio"] as? String
      
        
        comment.saveInBackground { (success, error) in
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
       
        
       // return self.hi.text = comment["bio"] as? String
        }
        
        @objc func keyboardWillBeHidden(note: Notification) {
            commentBar.inputTextView.text = nil
            showsCommentBar = false
            becomeFirstResponder()
        }
    
   
    

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
        
        let people = PFObject(className: "User")

        
        
        let imageData = profPic.image!.pngData()
        
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        people["image"] = file
        
        
        people.saveInBackground { (success, error) in
            if success {
      
                //self.dismiss(animated: true, completion: nil)
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

