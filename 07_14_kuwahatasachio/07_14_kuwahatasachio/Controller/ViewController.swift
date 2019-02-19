//
//  ViewController.swift
//  07_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/21.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SVProgressHUD

class ViewController: UIViewController ,FBSDKLoginButtonDelegate, UserDelegate{
    
    func loginTrans(error: Error?) {
        SVProgressHUD.dismiss()
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    // FBButtonの作成
    let fbLoginBtn = FBSDKLoginButton()
    
    // FBButtonでのLogin完了後に実行
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Error")
            return
        }
        // ログイン時の処理
        SVProgressHUD.show()
        User.shared.fblogin()
    }
    // FBButtonでのLogout完了後に実行
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        do {
            try User.shared.firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBAction func nextButton(_ sender: Any) {
        if let userName = userNameTextField.text {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
        self.performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLoginBtn.delegate = self
        self.fbLoginBtn.readPermissions = ["public_profile", "email"]
        self.fbLoginBtn.center = self.view.center
        self.view.addSubview(self.fbLoginBtn)

        SVProgressHUD.show()
        
        User.shared.delegate = self
        User.shared.fblogin()
    }
    
    @IBAction func checkButton(_ sender: Any) {
        let tokennn = FBSDKAccessToken.current()
        print("User: \(User.shared.firebaseAuth.currentUser)")
        print("token: \(tokennn)")
                
        // 本来はココ不要
        User.shared.fblogin()
    }

}

