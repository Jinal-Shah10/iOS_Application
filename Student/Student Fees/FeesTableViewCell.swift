//
//  FeesTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 28/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class FeesTableViewCell: UITableViewCell {

    @IBOutlet weak var sem: UILabel!
    @IBOutlet weak var totalfees: UILabel!
    
    @IBOutlet weak var receivedfees: UILabel!
    
    @IBOutlet weak var pending: UILabel!
    
    func setfees(data: FeesModel)
    {
        sem.text = data.sem
        totalfees.text = data.totalfees
        receivedfees.text = data.receivedfees
        pending.text = data.pendingfees
    }
}
