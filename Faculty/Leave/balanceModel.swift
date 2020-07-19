//
//  balanceModel.swift
//  DemoApp
//
//  Created by Jinal Shah on 16/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation

class balanceModel {
    
    var type: String?
    var enjoy: String?
    var opening: String?
    var closing: String?
    
    init(type: String?,enjoy: String?,opening: String?,closing: String?) {
        self.type = type
        self.enjoy = enjoy
        self.opening = opening
        self.closing = closing
    }
}
