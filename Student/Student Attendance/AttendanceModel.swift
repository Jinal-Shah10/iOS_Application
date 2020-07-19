//
//  AttendanceModel.swift
//  DemoApp
//
//  Created by Jinal Shah on 14/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit

class AttendanceModel {
    
   // var subject: String?
    var subcode: String?
    var classtype: String?
    var present: String?
    var percentage: Double?
    
    init(classtype: String?, present: String?, percentage: Double?, subcode: String?){
        
        //self.subject = subject
        self.classtype = classtype
        self.present = present
        self.percentage = percentage
        self.subcode = subcode
    }
}
