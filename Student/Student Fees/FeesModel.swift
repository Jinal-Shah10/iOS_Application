//
//  FeesModel.swift
//  DemoApp
//
//  Created by Jinal Shah on 14/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit

class FeesModel {
    
    var sid: String?
    var sem: String?
    var totalfees: String?
    var receivedfees: String?
    var pendingfees: String?
    
    init(sid: String? ,sem: String?, totalfees: String?, receivedfees: String?, pendingfees: String?)
    {
        
        self.sid = sid
        self.sem = sem
        self.totalfees = totalfees
        self.receivedfees = receivedfees
        self.pendingfees = pendingfees
        
    }
    
}
