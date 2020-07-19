//
//  subjectTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 03/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class subjectattTableViewCell: UITableViewCell {

    
    @IBOutlet weak var subname: UILabel!
    
    func setsubjectcard(data: subjectmodel)
    {
       
        subname.text = ((data.subcode as! String)+"-"+(data.subname as! String)) as! String
        
    }
}
