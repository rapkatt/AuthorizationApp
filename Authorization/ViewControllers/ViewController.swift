//
//  ViewController.swift
//  Authorization
//
//  Created by Baudunov Rapkat on 4/3/20.
//  Copyright © 2020 Baudunov Rapkat. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController,GIDSignInDelegate {
    

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLogin: UIButton!
    @IBOutlet weak var numberOu: UITextField!
    @IBOutlet weak var otpOu: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @IBAction func facebookActionLogin(_ sender: Any) {
        let loginManager = LoginManager()
               loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                   if let error = error {
                       print("Failed to login: \(error.localizedDescription)")
                       return
                   }
                   
                   guard let accessToken = AccessToken.current else {
                       print("Failed to get access token")
                       return
                   }
        
                   let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                   
                   Auth.auth().signIn(with: credential, completion: { (user, error) in
                       if let error = error {
                           print("Login error: \(error.localizedDescription)")
                           let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                           let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                           alertController.addAction(okayAction)
                           self.present(alertController, animated: true, completion: nil)
                           return
                       }else {
                        self.transitionToHome()
                       }
                   
                   })
        
               }
    }
    
    @IBAction func googleActionLogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            return
        }
        guard let authentication = user.authentication else {
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (autoResult, error) in
            if error != nil {
                return
            }else{
                 self.transitionToHome()
            }
        }
    }
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constrans.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }

    @IBAction func sendNumber(_ sender: Any) {
    }
    @IBAction func sendOtp(_ sender: Any) {
    }
}

