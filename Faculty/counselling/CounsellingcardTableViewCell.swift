//
//  CounsellingcardTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 09/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class CounsellingcardTableViewCell: UITableViewCell {

    @IBOutlet weak var idlbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var moblbl: UILabel!
    
    func setstudents(data: counsellingModel)
    {
        idlbl.text = data.sid!+"-"+data.name!
        citylbl.text = data.city
        moblbl.text = data.mobnum
    }
    
   
}
