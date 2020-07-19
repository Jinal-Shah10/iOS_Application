//
//  balancestatusTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 15/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class balancestatusTableViewCell: UITableViewCell {

    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var todate: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var status: UILabel!
    
    
    func setstatus(data: statusModel)
    {
        type.text = data.type
        from.text = data.fromdate
        todate.text = data.todate
        status.text = data.status
    }

}
