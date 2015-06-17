//
//  FaceInfoController.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 4/7/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import Foundation

class FaceInfoController : UITableViewController, UITableViewDelegate, UITableViewDataSource{
    var receiveData: Dictionary<String,Int>!
    
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
        return receiveData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! UITableViewCell
        
        switch (indexPath.row) {
        case 0:
            cell.textLabel?.text = "眼镜"
            cell.detailTextLabel?.text = receiveData["Eyeglasses"] == 1 ? "有戴" : "没戴"
            
            break;
        case 1:
            cell.textLabel?.text = "性别"
            cell.detailTextLabel?.text = receiveData["Male"] == 1 ? "男" : "女"
            
            break;
        case 2:
            cell.textLabel?.text = "微笑"
            cell.detailTextLabel?.text = receiveData["Smiling"] == 1 ? "有" : "无"
        
            break;
            
        default:
            break;
        }

        return cell;
    }
}