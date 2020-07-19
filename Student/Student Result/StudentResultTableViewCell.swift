//
//  StudentResultTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 22/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class StudentResultTableViewCell: UITableViewCell {
    
   
    
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var credit: UILabel!
    @IBOutlet weak var grade: UILabel!
    
   
    func setresultcard(data: ResultModel)
    {
        code.text = data.coursecode
        type.text = data.coursetype
        credit.text = data.credit
        grade.text = data.grade
    }

}
class StudentSemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var month: UILabel!
    
    @IBOutlet weak var sem: UILabel!
    
   
    
    func setstudentresultdata (data: ResultModel)
    {
        month.text = data.monthandyear
        sem.text = data.sem
    }
    
   
}
