//
//  punchTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 17/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class punchTableViewCell: UITableViewCell {

    @IBOutlet weak var pdate: UILabel!
    @IBOutlet weak var inpunch: UILabel!
    @IBOutlet weak var outpunch: UILabel!
    
    func setpunch(data: punchModel)
    {
        pdate.text = data.pdate
        inpunch.text = data.inpunch
        outpunch.text = data.outpunch
    }
}
