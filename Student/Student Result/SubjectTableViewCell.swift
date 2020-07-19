//
//  SubjectTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 01/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var coursecode: UILabel!
    @IBOutlet weak var subname: UILabel!
    
    func setsubjectcard(data: subjectmodel)
    {
        coursecode.text = data.subcode
        subname.text = data.subname
      
    }
    
}
