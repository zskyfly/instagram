//
//  PhotosTableViewCell.swift
//  instagram
//
//  Created by Zachary Matthews on 2/12/16.
//  Copyright © 2016 zskyfly productions. All rights reserved.
//

import AFNetworking
import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func addPhotoToCell(photoUrl: NSURL) {
        photoImageView.setImageWithURL(photoUrl)
    }
}
