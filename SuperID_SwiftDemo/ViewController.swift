//
//  ViewController.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 1/30/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController ,SuperIDDelegate {
    @IBOutlet weak var useraccount: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup view
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SuperID.setupSuperIDDelegate(self)
    }

    @IBAction func SuperIDBtn(_ sender: AnyObject) {
        
        let SuperID_LoginView: AnyObject!
        do {
            SuperID_LoginView = try SuperID.obtainLoginViewController(with: nil)
            if (SuperID_LoginView != nil){
                self.present(SuperID_LoginView as! UIViewController, animated: true, completion: nil)
            }
        } catch let error as NSError {
            print("loginView Error = \(error.code) : \(error.localizedDescription)")
        }

    }
    @IBAction func loginBtn(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "ShowPerson", sender: nil)
    }
    
    @objc(superID:userDidFinishLoginWithUserInfo:openId:error:) func superID(_ sender: SuperID!, userDidFinishLoginWithUserInfo userInfo: [AnyHashable: Any]!, openId: String!, error: Error!) {
        print("Login Done : \(userInfo) and \(openId)")
        self.performSegue(withIdentifier: "ShowPerson", sender: userInfo)
    }
    
    func superID(_ sender: SuperID!, userLoginFail error: NSError!) {
        print("loginView Error = \(error.code) : \(error.localizedDescription)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "ShowPerson") {
            let personView : PersonalCenter = segue.destination as! PersonalCenter
            personView.navigationItem.hidesBackButton = true;
            if((sender) != nil){
                personView.receiveData = sender as! Dictionary<String, AnyObject>
            }
        }
    }
    
    
    func setupView(){

        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated:true)
        
        self.view.backgroundColor = Superid_Demo_Artboard
        navigationItem.title="一登Demo"
        navigationController?.navigationBar.tintColor=UIColor.white
        navigationController?.navigationBar.barTintColor = Superid_Demo_Theme
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.backgroundColor = UIColor.white
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        confirmBtn.backgroundColor = Superid_Demo_Theme
        confirmBtn.clipsToBounds = true
        confirmBtn.layer.borderColor = UIColor.clear.cgColor
        confirmBtn.layer.borderWidth = 0.5
        confirmBtn.layer.cornerRadius = 4
        confirmBtn.titleLabel?.font = Superid_Size_Font_Title
        confirmBtn.titleLabel?.textColor = Superid_Demo_Font_White
        
        initTextFild(useraccount)
        initTextFild(password)
        
    }
    
    func initTextFild(_ textField: UITextField) {
        
        textField.backgroundColor = UIColor.white
        textField.keyboardAppearance = UIKeyboardAppearance.light
        textField.textColor = Superid_Demo_Font_Title
        textField.font = Superid_Size_Font_Title
        textField.textAlignment = NSTextAlignment.center
        textField.clearButtonMode=UITextFieldViewMode.whileEditing
        textField.layer.cornerRadius = 4.0
        textField.clipsToBounds = true
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = Superid_Demo_Border.cgColor
    }
}

