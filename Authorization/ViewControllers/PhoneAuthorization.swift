//
//  PhoneAuthorization.swift
//  Authorization
//
//  Created by Baudunov Rapkat on 4/7/20.
//  Copyright © 2020 Baudunov Rapkat. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class PhoneAuthorization: UIViewController {
    
    @IBOutlet weak var otpOu: UITextField!
    @IBOutlet weak var phoneOu: UITextField!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func PhoneSignin(_ sender: Any) {
        guard let phoneNumber = phoneOu.text else {
            return
        }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationId, error) in
            if error == nil{
                //print(verificationId)
                guard let verifyId = verificationId else{ return }
                self.userDefault.set(verifyId, forKey: "verificationId")
                self.userDefault.synchronize()
            }else{
                print("error",error?.localizedDescription)
            }
        }
    }
    
    
    @IBAction func verifyOTP(_ sender: Any) {
        guard let otpNumner = otpOu.text else { return }
        
        guard let verificationId = userDefault.string(forKey: "verificationId") else { return }
        
        let credetial = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpNumner)
        
        Auth.auth().signInAndRetrieveData(with: credetial) { (success, error) in
            if error == nil {
                self.transitionToHome()
            }else{
                print("error")
            }
        }
        
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constrans.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}
