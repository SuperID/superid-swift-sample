//
//  ProfileCell.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 2/3/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import Foundation

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    
    override func awakeFromNib() {
        profileImg.layer.cornerRadius = profileImg.frame.width/2
        profileImg.clipsToBounds = true
    }
}