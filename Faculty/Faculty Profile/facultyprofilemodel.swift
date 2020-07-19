//
//  facultyprofilemodel.swift
//  DemoApp
//
//  Created by Jinal Shah on 08/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation

class facultyprofilemodel {
    
    var Name: String?
    var Empid: String?
    var JoiningDate: String?
    var Passportno: String?
    var adharnum: String?
    var Passportexpdt: String?
    var PANno: String?
    var UANno: String?
    var PFno: String?
    
    init(Name: String?, Empid: String?, JoiningDate: String?, Passportno: String?, adharnum: String?, Passportexpdt: String?, PANno: String? , UANno: String?, PFno: String?){
        
        self.Name = Name
        self.Empid = Empid
        self.JoiningDate = JoiningDate
        self.Passportno = Passportno
        self.adharnum = adharnum
        self.Passportexpdt = Passportexpdt
        self.PANno = PANno
        self.UANno = UANno
        self.PFno = PFno
        
    }
}
