//
//  ResultModel.swift
//  DemoApp
//
//  Created by Jinal Shah on 14/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit

class ResultModel {
    
    var sem: String?
    var coursetype: String?
    var coursecode:String?
    var monthandyear: String?
    var grade: String?
    var credit: String?
    var examid: String?
    
    init(sem: String?, coursetype: String?, coursecode:String?, monthandyear: String?, grade: String?, credit: String?, examid: String?) {
        
        self.sem = sem
        self.coursetype = coursetype
        self.coursecode = coursecode
        self.monthandyear = monthandyear
        self.grade = grade
        self.credit = credit
        self.examid = examid
    }
    
}
