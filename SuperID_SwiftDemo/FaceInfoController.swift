//
//  FaceInfoController.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 4/7/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import Foundation

class FaceInfoController : UITableViewController, UITableViewDelegate, UITableViewDataSource{
    var receiveData: [String: AnyObject]!
    var faceFeature: JSON!
    
    override func viewDidLoad() {
        self.view.backgroundColor = Superid_Demo_Artboard
        tableView.backgroundColor = Superid_Demo_Artboard
        self.navigationItem.title = "人脸信息识别"
        tableView.delegate = self
        tableView.dataSource = self
        faceFeature = JSON(receiveData)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faceFeature.count - 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! UITableViewCell
        var detailText : String = ""
        
        switch (indexPath.row) {
        case 3:
            
            cell.textLabel?.text = "眼镜"
            detailText = faceFeature["eyeglasses"]["result"].number == 1 ? "有戴" : "没戴"
            break
            
        case 1:
            
            cell.textLabel?.text = "性别"
            detailText = faceFeature["male"]["result"].number == 1 ? "男" : "女"
            break
            
        case 2:
            
            cell.textLabel?.text = "微笑"
            detailText = faceFeature["smiling"]["result"].number == 1 ? "有" : "无"
            break
            
        case 4:
            
            cell.textLabel?.text = "太阳眼镜"
            detailText = faceFeature["sunglasses"]["result"].number == 1 ? "有戴" : "没戴"
            break
            
        case 0:
            
            cell.textLabel?.text = "年龄"
            detailText = String(stringInterpolationSegment: faceFeature["age"].number as! Float)
            break
            
        case 5:
            
            cell.textLabel?.text = "胡须"
            detailText = faceFeature["mustache"]["result"].number == 1 ? "有" : "无"
            break
            
        default:
            break
        }

        cell.detailTextLabel?.text = detailText
        
        return cell;
    }
    
}