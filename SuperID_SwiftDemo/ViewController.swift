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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SuperID.sharedInstance().delegate = self;
    }

    @IBAction func SuperIDBtn(sender: AnyObject) {
        
        let SuperID_LoginView: AnyObject!
        do {
            SuperID_LoginView = try SuperID.sharedInstance().obtainLoginViewController()
            if (SuperID_LoginView != nil){
                self.presentViewController(SuperID_LoginView as! UIViewController, animated: true, completion: nil)
            }
        } catch let error as NSError {
            print("loginView Error = \(error.code) : \(error.localizedDescription)")
        }

    }
    @IBAction func loginBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowPerson", sender: nil)
    }
    
    
    func superID(sender: SuperID!, userDidFinishLoginWithUserInfo userInfo: [NSObject : AnyObject]!, withAppUid uid: String!, error: NSError!) {
        print("Login Done : \(userInfo) and \(uid)", appendNewline: false)
        self.performSegueWithIdentifier("ShowPerson", sender: userInfo)
    }
    
    func superID(sender: SuperID!, userLoginFail error: NSError!) {
        print("loginView Error = \(error.code) : \(error.localizedDescription)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "ShowPerson") {
            let personView : PersonalCenter = segue.destinationViewController as! PersonalCenter
            personView.navigationItem.hidesBackButton = true;
            if((sender) != nil){
                personView.receiveData = sender as! Dictionary<String, AnyObject>
            }
        }
    }
    
    
    func setupView(){

        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated:true)
        
        self.view.backgroundColor = Superid_Demo_Artboard
        navigationItem.title="一登Demo"
        navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = Superid_Demo_Theme
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(16)]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        confirmBtn.backgroundColor = Superid_Demo_Theme
        confirmBtn.clipsToBounds = true
        confirmBtn.layer.borderColor = UIColor.clearColor().CGColor
        confirmBtn.layer.borderWidth = 0.5
        confirmBtn.layer.cornerRadius = 4
        confirmBtn.titleLabel?.font = Superid_Size_Font_Title
        confirmBtn.titleLabel?.textColor = Superid_Demo_Font_White
        
        initTextFild(useraccount)
        initTextFild(password)
        
    }
    
    func initTextFild(textField: UITextField) ->UITextField{
        
        textField.backgroundColor = UIColor.whiteColor()
        textField.keyboardAppearance = UIKeyboardAppearance.Light
        textField.textColor = Superid_Demo_Font_Title
        textField.font = Superid_Size_Font_Title
        textField.textAlignment = NSTextAlignment.Center
        textField.clearButtonMode=UITextFieldViewMode.WhileEditing
        textField.layer.cornerRadius = 4.0
        textField.clipsToBounds = true
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = Superid_Demo_Border.CGColor
    
        return textField;
    }
}

