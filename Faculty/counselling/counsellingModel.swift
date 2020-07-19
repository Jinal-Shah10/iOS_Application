//
//  counsellingModel.swift
//  DemoApp
//
//  Created by Jinal Shah on 10/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation

class counsellingModel
{
    var sid: String?
    var name: String?
    var city: String?
    var mobnum: String?
    
    init(sid: String?,name: String?,city: String?,mobnum: String?) {
        self.sid = sid
        self.name = name
        self.city = city
        self.mobnum = mobnum
    }
}
