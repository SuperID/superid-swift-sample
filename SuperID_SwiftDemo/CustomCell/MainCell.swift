//
//  MainCell.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 2/3/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import Foundation

class MainCell: UITableViewCell {
    
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var bundleLable: UILabel!
    
    override func awakeFromNib() {
        nameLable.font = Superid_Size_Font_Title
        nameLable.textColor = Superid_Demo_Font_Title
        iconImg.contentMode = UIViewContentMode.ScaleAspectFit
        bundleLable.textColor = Superid_Demo_Theme
        bundleLable.font = Superid_Size_Font_Text
    }
}