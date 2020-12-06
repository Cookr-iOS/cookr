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

    
    @IBOutlet weak var userName: UILabel!
    
    var posts = [PFObject]()
    var imageFiles = [PFFileObject]()
    let commentBar = MessageInputBar()
    
    var showsCommentBar = false

     var refreshControl: UIRefreshControl!
     var selectedPost: PFObject!
    
   @IBOutlet weak var profPic: UIImageView!
 
   
    @IBOutlet weak var bio: UILabel!
    
    
    @IBOutlet weak var buttonB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Update Bio..."
              commentBar.sendButton.title = "Post"
              commentBar.delegate = self
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let people = PFObject(className: "User")
        
   
        
        let query = PFQuery(className: "User")
        query.includeKeys(["author", "comments"])
        query.findObjectsInBackground { (objects, error) in
            if error == nil
            {
                if let returnedobjects = objects
                {
                    for object in returnedobjects
                    {

                        let comments = (people["comments"] as? [PFObject]) ?? []
                        
                        self.userName.text = PFUser.current()?.username
                        
//                        self.bio.text = comments["comments"] as? String
                        
                        
                        let file = object["image"] as? PFFileObject
                        
                        file?.getDataInBackground { (imageData: Data?, error: Error?) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else if let imageData = imageData {
                                let image = UIImage(data: imageData)
                                self.profPic.image = image
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
            // Create the comment
            let comment = PFObject(className: "comment")
            comment["bio"] = text
            comment["author"] = PFUser.current()
            
            selectedPost.add(comment, forKey: "bio")
            
            selectedPost.saveInBackground { (success, error) in
                if success {
                    print("Comment Saved!")
                }
                
                else {
                    print("Error Saving Comment!")
                }
            }
            
//            tableView.reloadData()
            
            // Clear and dismiss the input bar
            commentBar.inputTextView.text = nil
            
            showsCommentBar = false
            becomeFirstResponder()
            commentBar.inputTextView.resignFirstResponder()
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

