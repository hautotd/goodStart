//
//  Singleton.swift
//  App_V0
//
//  Created by Dimitri Hautot on 24/08/2014.
//  Copyright (c) 2014 Dimitri Hautot. All rights reserved.
//

import Foundation

class SingletonB {
    
    class var sharedInstance : SingletonB {
  
        func setprenom(pre : NSString){
            self.prenom = pre
        }
    struct Static {
        static let instance : SingletonB = SingletonB()
        }
        return Static.instance
    }
    
}