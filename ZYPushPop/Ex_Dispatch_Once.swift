//
//  Ex_Dispatch_Once.swift
//  Swift-RewritePushAndPop
//
//  Created by Jian, Xin X. -ND on 2017/4/7.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class Ex_Dispatch_Once: NSObject {
}

public extension DispatchQueue {
    
    fileprivate static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(_ token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

