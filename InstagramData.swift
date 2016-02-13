//
//  InstagramData.swift
//  instagram
//
//  Created by Zachary Matthews on 2/12/16.
//  Copyright © 2016 zskyfly productions. All rights reserved.
//

import Foundation

class InstagramData {

    var data: NSDictionary!

    init (data: NSDictionary) {
        self.data = data
    }

    func getLowResPhotoUrl() -> NSURL {
        let url = self.data.valueForKeyPath("images.low_resolution.url") as! String
        return NSURL(string: url)!
    }
    
    func getStandardResPhotoUrl() -> NSURL {
        let url = self.data.valueForKeyPath("images.standard_resolution.url") as! String
        return NSURL(string: url)!
    }
}