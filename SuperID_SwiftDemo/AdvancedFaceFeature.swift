//
//  AdvancedFaceFeature.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 4/7/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import Foundation
class AdvancedFaceFeature : SIDFaceFeatureViewController {
    var hud : MBProgressHUD!
    
    @IBOutlet weak var startFaceFeature: UIButton!
    
    override func viewDidLoad() {
        self.navigationItem.title = "自定义人脸界面"
        
        self.configureFaceFeatureView(withDuration: 10.0, withFrameWidth: 320.0, high: 320.0);
        self.view.backgroundColor = UIColor.black;
        
        if(hud == nil){
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.removeFromSuperViewOnHide = false
            hud.hide(false)
        }
        
    }
    
    @IBAction func start(_ sender: AnyObject) {
        self.startDetectFaceFeature()
        self.startFaceFeature.isHidden = true
        hud.mode = MBProgressHUDModeIndeterminate
        hud.labelText = "人脸信息获取中"
        hud.show(true)
    }
    
    override func getFaceFeatureSucceed(withFeatureInfo featureInfo: [AnyHashable: Any]!) {
        print("获取人脸表情成功\(featureInfo)")
        
        self.startFaceFeature.isHidden = false
        hud.mode = MBProgressHUDModeText
        hud.labelText = "获取人脸信息成功"
        hud.show(true)
        hud.hide(true, afterDelay: 1.5)
    }
    
    override func getFaceFeatureFail(_ error: Error!) {
        
        print("获取人脸表情失败")
        
        self.startFaceFeature.isHidden = false;
        hud.mode = MBProgressHUDModeText;
        
        if (error._code == -1016) {
            
            hud.labelText = "获取人脸信息失败"
            
        }else if (error._code == -1007){
            
            hud.labelText = "帐号授权失效"
            
        }else if (error._code == -1015){
            
            hud.labelText = "当前帐号已被冻结"
            
        }
        hud.show(false)
        hud.hide(true, afterDelay: 1.5)

    }
    
}
