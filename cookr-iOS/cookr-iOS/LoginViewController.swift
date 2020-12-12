//
//  LoginViewController.swift
//  cookr-iOS
//
//  Created by Jonathan Zamora on 12/5/20.
//

import UIKit
import Parse
import AlamofireImage
import Alamofire

class LoginViewController: UIViewController {
    
    let user = PFUser.current()
    
    var users = [PFObject]()
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Users")
        query.includeKey("author")
        query.limit = 20
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (users, error) in
            if users != nil {
                self.users = users!
                
                if self.user?["image"] == nil{
                    self.user?["image"] = Image.init(contentsOfFile: "cookr-iOS/Assets.xcasset/AppIcon.appiconset/29.png")
                }
             
            
            }
        }
    }
    
    @IBAction func onSignIn(_ sender: Any)
    {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func onSignUp(_ sender: Any)
    {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
}
