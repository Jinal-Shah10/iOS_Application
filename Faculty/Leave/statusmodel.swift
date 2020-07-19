//
//  statusmodel.swift
//  DemoApp
//
//  Created by Jinal Shah on 16/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation

class statusModel {
    
    var fromdate: String?
    var todate: String?
    var type: String?
    var status: String?

        init(fromdate: String?,todate: String?,type: String?,status: String?)
        {
            self.type = type
            self.fromdate = fromdate
            self.todate = todate
            self.status = status
    }

}
