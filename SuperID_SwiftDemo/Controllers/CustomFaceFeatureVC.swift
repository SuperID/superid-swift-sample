//
//  CustomFaceFeatureVC.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 04/11/2016.
//  Copyright © 2016 GYX. All rights reserved.
//

import UIKit

/// Step_1:  集成视图控制器类|SIDFaceFeatureViewController|
class CustomFaceFeatureVC: SIDFaceFeatureViewController {

    /// 此view不仅支持xib创建,也可以代码生成,可以灵活设置此view大小
    @IBOutlet weak var preView: SIDCameraPreviewView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Step_2:  设置预览视频view,三方可以根据自身业务,灵活设置此view的大小,也可以设置隐藏
        self.navigationItem.title = "自定义人脸属性"
        self.setupFaceFeatureManager(withPreview: self.preView)
        print(self.preView.frame)
    }

    // MARK: - SuperIDDelegate
    /// Step_3: 重写下面三个方法,三方可以根据自身业务,灵活设计UI交互
    
    override func didFinishDetectFace() {
        print("检查到人脸,调用此方法")
    }
    
    override func getFaceFeatureFail(_ error: Error!) {
        print("检查人脸属性错误 : \(error)")
    }
    
    override func getFaceFeatureSucceed(withFeatureInfo featureInfo: [AnyHashable : Any]!) {
        print("检测结果: \(featureInfo)")
        UIAlertView(title: "检测结果", message: "\(featureInfo)", delegate: nil, cancelButtonTitle: "我知道了").show()
    }

    /// 开始检测人脸属性
    @IBAction func start(_ sender: Any) {
        self.startDetectFaceFeature()
    }
    
    /// 停止检测人脸属性
    @IBAction func stop(_ sender: Any) {
        self.stopDetectFaceFeature()
    }

    /// 可以设置隐藏预览视频view
    @IBAction func hiddenCameraView(_ sender: Any) {
        self.preView.isHidden = !self.preView.isHidden
    }
}
