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

class ViewController: UIViewController,GIDSignInDelegate {
    

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
       
        
        
//        let googleButton = GIDSignInButton()
//        googleButton.frame = CGRect(x:16,y:50,width: view.frame.width - 32,height: 50)
//        view.addSubview(googleButton)
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

}
