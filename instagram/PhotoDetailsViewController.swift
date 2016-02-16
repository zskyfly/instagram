//
//  PhotoDetailsViewController.swift
//  instagram
//
//  Created by Zachary Matthews on 2/12/16.
//  Copyright © 2016 zskyfly productions. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UIGestureRecognizerDelegate {

    internal var photoUrl: NSURL!

    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureRecognizer.delegate = self
        photoImageView.setImageWithURL(photoUrl)
        photoImageView.userInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMyPhotoUrl(url: NSURL) {
        self.photoUrl = url
    }
    
    @IBAction func didTapImage(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("segueFullScreenPhoto", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destinationViewController = segue.destinationViewController as! FullScreenPhotoViewController
        
        destinationViewController.photoUrl = self.photoUrl
        
    }
}
