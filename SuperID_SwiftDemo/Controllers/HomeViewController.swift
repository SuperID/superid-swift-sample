//
//  HomeViewController.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 03/11/2016.
//  Copyright © 2016 GYX. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let sectionTitles = ["基本功能", "深度集成"]
    let cellTitles = [
        ["一登登录", "人脸表情", "刷脸认证", "解除绑定", "退出登录"],
        ["人脸属性VC", "人脸检索VC"]
    ]
    var login = SuperID.isAppAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "一登SDK"
    }
    
    // MARK: - SuperIDDelegate
    func showMessage(title: String, message: String!) {
        UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "我知道了").show()
    }
    
    /// 一登登录
    func superIDLogin() {
        SIDCoreLoginKit.showLoginViewController(with: nil, responseBlock: {
            (result:[AnyHashable : Any]?, error:Error?) -> Void in
            
            if error == nil {
                //授权登录成功
                print("userInfo:\(result)")
                self.showMessage(title: "一登登录成功", message: "控制台打印一登回传的数据")
                self.login = true
                self.tableView.reloadData()
            } else {
                //授权登录失败
                print("Login Fail Error = \(error) ")
            }
        })
    }
    
    /// 人脸表情
    func faceEmotion()  {
        SIDCoreLoginKit.showFaceFeatureViewController(responseBlock: {
            (result:[AnyHashable : Any]?, error:Error?) -> Void in
            
            if error == nil {
                // 人脸表情成功
                print("人脸表情获取成功,返回给开发者表情数据: \(result)")
                self.showMessage(title: "人脸表情获取成功", message: "控制台打印一登回传的表情数据")
            } else {
                // 人脸表情失败
                print("Face Feature Error = \(error) ")
            }
        })
    }
    
    /// 刷脸认证
    func faceVerify() {
        SIDCoreLoginKit.showFaceVerifyViewController(withRetryCount: nil, responseBlock: {
            (result:SIDFACEVerifyState, error:Error?) -> Void in
            var title = "刷脸验证失败"
            if error == nil {
                if result == SIDFACEVerifyState.SIDFaceVerifySucceed {
                    title = "刷脸验证成功"
                    print("刷脸验证成功")
                }else {
                    print("刷脸验证失败")
                }
            } else {
                // 人脸表情失败
                print("FaceVerify Error = \(error) ")
            }
            self.showMessage(title: title, message: nil)
        })
    }
    
    /// 解除绑定
    func relieveBinding() {
        SuperID.userCancelAuthorization()
        self.showMessage(title: "解除绑定成功", message: nil)
        login = false
        self.tableView.reloadData()
    }
    
    /// 退出登录
    func quitSuperIDLogin() {
        SuperID.appUserLogoutCurrentAccount()
        self.showMessage(title: "退出登录成功", message: nil)
        login = false
        self.tableView.reloadData()
    }


    // MARK: - Table view data source
    
    func enableCell(index: IndexPath) -> Bool {
        if index.section == 0 && index.row == 0 {
            return !login
        } else if index.section == 1 {
            return true
        } else {
            return login
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = cellTitles[indexPath.section][indexPath.row]
        if enableCell(index: indexPath) {
            cell.textLabel?.textColor = UIColor.black
        } else {
            cell.textLabel?.textColor = UIColor.lightGray
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return enableCell(index: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                self.superIDLogin()
                break
            case 1:
                self.faceEmotion()
                break
            case 2:
                self.faceVerify()
                break
            case 3:
                self.relieveBinding()
                break
            case 4:
                self.quitSuperIDLogin()
                break
            default:
                return
            }
        } else {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(CustomFaceFeatureVC(), animated: true)
                break
            default:
                return
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
