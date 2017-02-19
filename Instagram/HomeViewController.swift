//
//  HomeViewController.swift
//  Instagram
//
//  Created by Richard Du on 2/14/17.
//  Copyright © 2017 Richard Du. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        //construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                // do something with the data fetched
                self.posts = posts
                self.tableView.reloadData()
            } else {
                // handle error
                print("\(error!.localizedDescription)")
            }
        }
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeViewController.onTimer), userInfo: nil, repeats: true)
    }

    func onTimer() {
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                // do something with the data fetched
                self.posts = posts
                self.tableView.reloadData()
            } else {
                // handle error
                print("\(error!.localizedDescription)")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramPostCell", for: indexPath) as! InstagramPostCell
        
        let post = posts?[indexPath.row]
        cell.captionLabel.text = post?["caption"] as? String
        let imageFile = post?["media"] as! PFFile
        imageFile.getDataInBackground(block: { (data:Data?, error:Error?) in
            if error == nil {
                if let data = data {
                    cell.postImageView.image = UIImage(data: data)
                    //print("Got photo")
                }
                //print("Got Data")
            } else {
                print("\(error!.localizedDescription)")
            }
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
