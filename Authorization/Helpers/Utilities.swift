//
//  Utilities.swift
//  Authorization
//
//  Created by Baudunov Rapkat on 4/4/20.
//  Copyright © 2020 Baudunov Rapkat. All rights reserved.
//

import Foundation
class Utilities{
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
