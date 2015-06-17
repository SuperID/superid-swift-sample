//
//  PersonalCenter.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 2/3/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import Foundation

class PersonalCenter : UIViewController, SuperIDDelegate, UITableViewDelegate,UITableViewDataSource {
    var receiveData: Dictionary<String, AnyObject>!
    var user : NSUserDefaults!
    var hud : MBProgressHUD!
    @IBOutlet weak var tableView: UITableView!
    
    let iconArray: [String] = ["superid_demo_binding_wechat_ico_disable","superid_demo_binding_superid_ico_disable","superid_demo_binding_weibo_ico_disable"]
    let nameArray: [String] = ["微信","一登","新浪微博"]
    let functionArray: [String] = ["人脸表情","人脸表情(隐藏版)"]
    
    override func viewDidLoad() {
        self.view.backgroundColor = Superid_Demo_Artboard;
        tableView.backgroundColor = Superid_Demo_Artboard;
        self.navigationItem.title = "个人中心";
        tableView.delegate = self
        tableView.dataSource = self
        SuperID.sharedInstance().delegate = self
        user = NSUserDefaults.standardUserDefaults()
        let userInfos : Dictionary? = user.objectForKey("UserInfo") as? Dictionary<String,AnyObject>
        if ((userInfos) != nil){
            receiveData = userInfos
        }else if((receiveData) != nil){
            let user : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            user.setObject(receiveData, forKey: "UserInfo")
        }
        
        if(hud == nil){
            hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.removeFromSuperViewOnHide = false
            hud.hide(false)
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }else if (section == 1){
            return 3
        }else if (section == 2){
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var customView : UIView = UIView.init(frame: CGRectMake(0, 0, self.view.frame.width,44))
        customView.backgroundColor = Superid_Demo_Artboard
        return customView

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }else{
            return 16
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 140
        }else{
            return 44
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            
            let cell : ProfileCell = tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! ProfileCell
            if ((receiveData) != nil){
                cell.userName.text = receiveData["name"] as? String
                cell.mobileNumber.text = receiveData["phone"] as? String
                if((user.objectForKey("UserAvatar")) != nil){
                    cell.profileImg.image = SANDBOXIMAGE("avatar.jpg")
                }else{
                    let url = NSURL(string:receiveData["avatar"] as! String)
                    var imageRequest: NSURLRequest = NSURLRequest(URL: url!)
                    NSURLConnection.sendAsynchronousRequest(imageRequest,
                        queue: NSOperationQueue.mainQueue(),
                        completionHandler:{response, data, error in
                            let avatarPath :String = SANDBOXIMAGEPATH("avatar.jpg")
                            data?.writeToFile(avatarPath, atomically: false);
                            self.user.setObject(avatarPath, forKey: "UserAvatar")
                            dispatch_async(dispatch_get_main_queue(),{
                                cell.profileImg.image = SANDBOXIMAGE("avatar.jpg")
                            })
                    }) 
                }
            }
            return cell
            
        }else if (indexPath.section == 1){
            
            let cell : MainCell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! MainCell
            
            cell.bundleLable.text = "点击绑定"
            cell.iconImg.image = UIImage(named:iconArray[indexPath.row])
            cell.nameLable.text = nameArray[indexPath.row]
            
            if(indexPath.row == 1 && SuperID.sharedInstance().isAppAuth()){
                cell.bundleLable.text = "解除绑定"
                cell.iconImg.image = UIImage(named:"superid_demo_binding_superid_ico_normal")
            }
            
            return cell
            
        }else if (indexPath.section == 2){
            let cell : MainCell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! MainCell
            cell.nameLable.text = functionArray[indexPath.row]
            cell.bundleLable.text = "点击体验"
            
            return cell
        
        }else{
            let cell : LogoutCell = tableView.dequeueReusableCellWithIdentifier("logoutCell", forIndexPath: indexPath) as! LogoutCell
            
            return cell
        }

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0) {
            
            let cell : ProfileCell = tableView.cellForRowAtIndexPath(indexPath) as! ProfileCell
            cell.selected = false
            
            
        }else if (indexPath.section == 1){
            
            let cell : MainCell = tableView.cellForRowAtIndexPath(indexPath) as! MainCell
            cell.selected = false
            
            if(indexPath.row == 1){
                if(SuperID.sharedInstance().isAppAuth()){
                    hud.mode = MBProgressHUDModeIndeterminate
                    hud.show(true)
                    SuperID.sharedInstance().userCancelAuthorization()

                }else{
                    let appUserInfo : Dictionary<String,String>! = ["name":"Yourtion","email":"yourtion@gmail.com","avatar":""]
                    var dateNow : String {
                    get {
                            return "\(NSDate().timeIntervalSince1970 * 1000)"
                        }
                    }
                    var phone : String! = nil
                    var authError: NSError?
                    let SuperID_AuthView: AnyObject! = SuperID.sharedInstance().obtainAuthViewControllerWithUid(dateNow, phoneNumber: phone, appUserInfo: appUserInfo, error: &authError)
                    if (authError != nil) {
                        if let error = authError {
                            println("loginView Error = \(error.code) : \(error.localizedDescription)")
                        }
                    }
                    if (SuperID_AuthView != nil){
                        self.presentViewController(SuperID_AuthView as! UIViewController, animated: true, completion: nil)
                    }
                }
            }
            
        }else if (indexPath.section == 2){
            let cell : MainCell = tableView.cellForRowAtIndexPath(indexPath) as! MainCell
            cell.selected = false
            
            if(indexPath.row == 0){
                var loginError: NSError?
                let SuperID_FaceFeature: AnyObject! = SuperID.sharedInstance().obtainFaceFeatureViewControllerWithError(&loginError)
                if (loginError != nil) {
                    if let error = loginError {
                        hud.mode = MBProgressHUDModeText
                        hud.labelText = "请先绑定一登"
                        hud.show(true)
                        hud.hide(true, afterDelay: 0.8)
                        println("loginView Error = \(error.code) : \(error.localizedDescription)")
                    }
                }
                if (SuperID_FaceFeature != nil){
                    self.presentViewController(SuperID_FaceFeature as! UIViewController, animated: true, completion: nil)
                }
            }
            
            if(indexPath.row == 1){
                self.performSegueWithIdentifier("ShowAdvanceFaceInfo", sender: self)
            }
            
        }else{
            // SuperID.sharedInstance().appUserLogoutCurrentAccount()
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

    
    func superID(sender: SuperID!, userDidFinishAuthAppWithUserInfo userInfo: [NSObject : AnyObject]!, withAppUid uid: String!) {
        print("Succeed !")
        receiveData = nil
        receiveData = userInfo as! Dictionary<String, AnyObject>
        tableView.reloadData()
        hud.mode = MBProgressHUDModeText
        hud.labelText = "绑定成功"
        hud.hide(true, afterDelay: 0.5)
    }
    
    
    func superID(sender: SuperID!, userAuthAppFail error: NSError!) {
        print("Fail !")
        hud.mode = MBProgressHUDModeText
        hud.labelText = "绑定失败"
        hud.hide(true, afterDelay: 0.5)
    }
    
    func superID(sender: SuperID!, userDidFinishCancelAuthorization error: NSError!) {
        if((error) != nil){
            hud.mode = MBProgressHUDModeText
            hud.labelText = "解绑失败"
            hud.hide(true, afterDelay: 0.5)
            print("CancelAuthorization Fail \(error.code) : \(error.localizedDescription)")
        }else{
            user.removeObjectForKey("UserInfo")
            user.removeObjectForKey("UserAvatar")
            receiveData = nil
            tableView.reloadData()
            hud.mode = MBProgressHUDModeText
            hud.labelText = "解绑成功"
            hud.hide(true, afterDelay: 0.5)
            print("Succeed!")
        }
    }
    
    func receieveNetWorkError(sender: SuperID!) {
        if (hud != nil && !hud.hidden){
            hud.mode = MBProgressHUDModeText
            hud.labelText = "网络错误"
            hud.hide(true, afterDelay: 0.5)
            print("NetWorkError")
        }
    }
    
    func superID(sender: SuperID!, userDidFinishGetFaceFeatureWithFeatureInfo featureInfo: [NSObject : AnyObject]!, error: NSError!) {
        if((error) != nil){
            println("GetFaceFeature Error = \(error.code) : \(error.localizedDescription)")
        }else{
            self.performSegueWithIdentifier("ShowFaceInfo", sender: featureInfo)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "ShowFaceInfo") {
            let faceInfoView : FaceInfoController = segue.destinationViewController as! FaceInfoController
            if((sender) != nil){
                faceInfoView.receiveData = sender as! [String: AnyObject]
            }
        }
    }

}