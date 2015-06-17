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
    
    override func viewDidLoad() {
        self.view.backgroundColor = Superid_Demo_Artboard
        tableView.backgroundColor = Superid_Demo_Artboard
        self.navigationItem.title = "人脸信息识别"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiveData.count - 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! UITableViewCell
        
        switch (indexPath.row) {
        case 3:
            
            cell.textLabel?.text = "眼镜"
            if let data = receiveData["eyeglasses"] as? [String: AnyObject]
            {
                cell.detailTextLabel?.text = data["result"] as? Int  == 1 ? "有戴" : "没戴"
            }
            break
            
        case 1:
            
            cell.textLabel?.text = "性别"
            if let data = receiveData["male"] as? [String: AnyObject]
            {
                cell.detailTextLabel?.text = data["result"] as? Int  == 1 ? "男" : "女"
            }
            break
            
        case 2:
            
            cell.textLabel?.text = "微笑"
            if let data = receiveData["smiling"] as? [String: AnyObject]
            {
                cell.detailTextLabel?.text = data["result"] as? Int  == 1 ? "有" : "无"
            }
            break
            
        case 4:
            
            cell.textLabel?.text = "太阳眼镜"
            if let data = receiveData["sunglasses"] as? [String: AnyObject]
            {
                cell.detailTextLabel?.text = data["result"] as? Int  == 1 ? "有" : "无"
            }
            break
            
        case 0:
            
            cell.textLabel?.text = "年龄"
            cell.detailTextLabel?.text = String(stringInterpolationSegment: receiveData["age"] as! Float)
            break
            
        case 5:
            
            cell.textLabel?.text = "胡须"
            if let data = receiveData["mustache"] as? [String: AnyObject]
            {
                cell.detailTextLabel?.text = data["result"] as? Int  == 1 ? "有" : "无"
            }
            break
            
        default:
            break
        }

        return cell;
    }
}