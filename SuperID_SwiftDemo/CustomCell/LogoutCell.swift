//
//  LogoutCell.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 2/3/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import Foundation

class LogoutCell: UITableViewCell {
    
    @IBOutlet weak var logoutLable: UILabel!
    
    override func awakeFromNib() {
        logoutLable.textColor = Superid_Demo_Theme
    }
}