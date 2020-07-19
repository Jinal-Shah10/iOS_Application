//
//  AttendanceTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 27/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var present: UILabel!
    @IBOutlet weak var percentage: UILabel!
    
    
    
    func setstudentAttendancedata (data: AttendanceModel)
    {
        //subject.text = data.subject
        
        type.text = data.classtype
        present.text = data.present
        percentage.text = data.percentage?.toString()
        subject.text = data.subcode
    }

}
