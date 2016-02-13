//
//  PhotoDetailsViewController.swift
//  instagram
//
//  Created by Zachary Matthews on 2/12/16.
//  Copyright © 2016 zskyfly productions. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    internal var photoUrl: NSURL!

    @IBOutlet var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.setImageWithURL(photoUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMyPhotoUrl(url: NSURL) {
        self.photoUrl = url
    }
}
