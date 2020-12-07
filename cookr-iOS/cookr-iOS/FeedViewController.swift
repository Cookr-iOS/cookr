//
//  FeedViewController.swift
//  cookr-iOS
//
//  Created by Jonathan Zamora on 12/5/20.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate/*, UITableViewDataSource*/ {
    
    @IBOutlet var tableView: UITableView!
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        //tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
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
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        tableView.dequeueReusableCell(withIdentifier: "userInfoCell") as! UserInfoTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedCellTableViewCell
        
        cell.titleLabel.text = post["title"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af_setImage(withURL: url)
        
        return cell
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
