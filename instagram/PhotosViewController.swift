//
//  PhotosViewController.swift
//  instagram
//
//  Created by Zachary Matthews on 2/12/16.
//  Copyright © 2016 zskyfly productions. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data = NSArray()
    @IBOutlet weak var photosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosTableView.dataSource = self
        photosTableView.delegate = self
        photosTableView.rowHeight = 320

        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
//                            NSLog("response: \(responseDictionary)")
                            self.data = responseDictionary["data"] as! NSArray
                            NSLog("results returned: \(self.data.count)")
                            self.photosTableView.reloadData()
                    }
                }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.zskyfly.PhotosTableViewCell", forIndexPath: indexPath) as! PhotosTableViewCell
        let index = indexPath.row
        let data = self.data[index] as! NSDictionary
        let lowResUrl = getLowResUrlFromData(data)
        cell.photoImageView?.setImageWithURL(lowResUrl)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("photo count \(self.data.count)")
        return self.data.count
    }
    
    func getLowResUrlFromData(data: NSDictionary) -> NSURL {
        let url = data.valueForKeyPath("images.low_resolution.url") as! String
        return NSURL(string: url)!
    }


}

