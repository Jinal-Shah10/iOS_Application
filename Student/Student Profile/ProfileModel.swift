//
//  ProfileModel.swift
//  DemoApp
//
//  Created by Jinal Shah on 14/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit

class ProfileModel {
    
    var sname: String?
    var sid: String?
    var dob: String?
    var bloodgrp: String?
    var adharnum: String?
    var cname: String?
    var mailid: String?
    var mobnum: String?
    var extnum: String?
    
    init(sname: String?, sid: String?, dob: String?, bloodgrp: String?, adharnum: String?, cname: String?, mailid: String? , mobnum: String?, extnum: String?){
        
        self.sname = sname
        self.sid = sid
        self.dob = dob
        self.bloodgrp = bloodgrp
        self.adharnum = adharnum
        self.cname = cname
        self.mailid = mailid
        self.mobnum = mobnum
        self.extnum = extnum
        
    }
}
