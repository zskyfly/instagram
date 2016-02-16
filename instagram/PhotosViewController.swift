//
//  PhotosViewController.swift
//  instagram
//
//  Created by Zachary Matthews on 2/12/16.
//  Copyright © 2016 zskyfly productions. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var instagramData = [InstagramData]()
    var isMoreDataLoading = false

    @IBOutlet weak var photosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosTableView.dataSource = self
        photosTableView.delegate = self
        photosTableView.rowHeight = 320

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        photosTableView.insertSubview(refreshControl, atIndex: 0)

        let tableFooterView: UIView = UIView(frame: CGRectMake(0, 0, 320, 50))
        let loadingView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        loadingView.startAnimating()
        loadingView.center = tableFooterView.center
        tableFooterView.addSubview(loadingView)
        self.photosTableView.tableFooterView = tableFooterView

        reloadPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = photosTableView.indexPathForCell(sender as! UITableViewCell)! as NSIndexPath
        let instagramResult = instagramData[indexPath.section]
        vc.setMyPhotoUrl(instagramResult.getStandardResPhotoUrl())
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = photosTableView.contentSize.height
            let scrollViewOffsetThreshold = scrollViewContentHeight - photosTableView.bounds.size.height
            if (scrollView.contentOffset.y > scrollViewOffsetThreshold && photosTableView.dragging) {
                isMoreDataLoading = true
                reloadPhotos(nil, replaceData: false)
            }
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.zskyfly.PhotosTableViewCell", forIndexPath: indexPath) as! PhotosTableViewCell
        let instagramResult = instagramData[indexPath.section]
        cell.addPhotoToCell(instagramResult.getLowResPhotoUrl())
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let instagramResult = instagramData[section]

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)

        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        profileView.setImageWithURL(instagramResult.getProfilePictureUrl())

        let usernameLabel = UILabel(frame: CGRect(x:50, y:10, width: 270, height: 30))
        // TODO: add blue color
        usernameLabel.textColor = UIColor(red: 18.0 / 255.0, green: 86.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0)
        usernameLabel.text = instagramResult.getUsername()
        
        let likeCountLabel = UILabel(frame: CGRect(x:160, y:10, width:150, height: 30))
        likeCountLabel.textAlignment = NSTextAlignment.Right
        likeCountLabel.textColor = UIColor(red: 165.0 / 255.0, green: 167.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
        likeCountLabel.font = UIFont(name: "System", size: CGFloat(10))
        likeCountLabel.text = instagramResult.getLikeCount()

        headerView.addSubview(profileView)
        headerView.addSubview(usernameLabel)
        headerView.addSubview(likeCountLabel)

        return headerView
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.instagramData.count
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        reloadPhotos(refreshControl)
    }

    func reloadPhotos(refreshControl: UIRefreshControl? = nil, replaceData: Bool = true) {
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
//                      NSLog("response: \(responseDictionary)")
                        self.initInstagramData(responseDictionary["data"] as! NSArray, replaceData: replaceData)
                        self.photosTableView.reloadData()
                        if refreshControl != nil {
                            refreshControl!.endRefreshing()
                        }
                        self.isMoreDataLoading = false
                    }
                }
        });
        task.resume()
    }

    func initInstagramData(data: NSArray, replaceData: Bool = true) {
        if (replaceData) {
        self.instagramData.removeAll()
        }

        for item in data {
            self.instagramData.append(InstagramData(data: item as! NSDictionary))
        }
    }
}

