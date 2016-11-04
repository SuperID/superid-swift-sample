//
//  CustomSearchFaceVC.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 04/11/2016.
//  Copyright © 2016 GYX. All rights reserved.
//

import UIKit

/// Step_1:  集成视图控制器类|SIDSearchFaceViewController|
/// Step_2:  遵守协议|SIDSearchFaceProtocol|
class CustomSearchFaceVC: SIDSearchFaceViewController, SIDSearchFaceProtocol {
    
    @IBOutlet weak var preView: SIDCameraPreviewView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "自定义人脸检索"
        /// Step_3:  设置预览视频view,三方可以根据自身业务,灵活设置此view的大小,也可以设置隐藏
        self.setupSearchFaceManager(withPreview: self.preView)
    }

    // MARK: - SuperIDDelegate
    /// Step_4:  实现协议|SIDSearchFaceProtocol|如下三个方法
    
    func hasGetTheUserFace() {
        print("检测到人脸")
    }
    
    func groupCompareResult(_ isSucceed: Bool, usersArray: [Any]!) {
        print("\(isSucceed) - \(usersArray)")
        UIAlertView(title: "结果", message: "\(usersArray)", delegate: nil, cancelButtonTitle: "我知道了").show()
    }
    
    func userCannotPassLivenessDetect() {
        UIAlertView(title: "请真人刷脸", message: nil, delegate: nil, cancelButtonTitle: "我知道了").show()
    }
    
    /// 开始搜索
    @IBAction func startSearch(_ sender: Any) {
        /// 关于sourceId和groupId,详情请查阅技术文档,
        self.startDetectFace(withSourceId: "oOLuPIbkuw1TBjO0m5oYe0YP", groupId: "82c00fe7ab820b6ceb3bf84093a2539d")
    }
    

}
