//
//  FullScreenPhotoViewController.swift
//  instagram
//
//  Created by Zachary Matthews on 2/15/16.
//  Copyright © 2016 zskyfly productions. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    internal var photoUrl: NSURL!

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var fullScreenScrollView: UIScrollView!
    @IBOutlet weak var fullScreenImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenScrollView.delegate = self
        fullScreenScrollView.userInteractionEnabled = true
        fullScreenImageView.setImageWithURL(photoUrl)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickDismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func setMyPhotoUrl(url: NSURL) {
        self.photoUrl = url
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        print("registered zooming view")
        return fullScreenImageView
    }
}
