//
//  Bankmodel.swift
//  DemoApp
//
//  Created by Jinal Shah on 08/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
class Bankmodel
{
    var Name: String?
    var code: String?
    var IFSC: String?
    var Accno: String?
    
    init(Name: String?,code: String?,IFSC: String?,Accno: String?){
        self.Name = Name
        self.code = code
        self.IFSC = IFSC
        self.Accno = Accno
        
    }
    
}
