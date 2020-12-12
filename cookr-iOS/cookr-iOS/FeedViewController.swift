//
//  FeedViewController.swift
//  cookr-iOS
//
//  Created by Jonathan Zamora on 12/5/20.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let user = PFUser.current()
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        //tableView.dequeueReusableCell(withIdentifier: "userInfoCell") as! UserInfoTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedCellTableViewCell
        
        cell.titleLabel.text = post["title"] as? String
        
        let author = post["author"] as! PFUser
        cell.usernameLabel.text = author.username

////--------STUCK ON CURRENT USER HERE - UPDATE prof pic for respective user -----
//        let pp = PFUser.current()
//        
//        if pp == nil {
//            pp?["image"] = Image.init()
//        }
//        else{
//            
//            let pp1 = self.user?["image"] as! PFFileObject
//            let urlString = pp1.url!
//            
//             
//            let url = URL(string: urlString)!
//            
//        let filter1 = AspectScaledToFillSizeFilter(size: cell.profilePhoto.frame.size)
//        cell.profilePhoto.af.setImage(withURL: url, filter: filter1)
//        }
//===================================

        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        let filter = AspectScaledToFillSizeFilter(size: cell.photoView.frame.size)
        cell.photoView.af.setImage(withURL: url, filter: filter)
        
        
//        let imageFile1 = self.user?["image"] as! PFFileObject
//        let urlString = imageFile.url!
//        let url = URL(string: urlString)!
//        
//        let filter = AspectScaledToFillSizeFilter(size: self.profPic.frame.size)
//        self.profPic.af.setImage(withURL: url, filter: filter)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(identifier: "RecipeViewController") as! RecipeViewController
        vc.post = post
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
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
