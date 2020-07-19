//
//  balanceleaveTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 15/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class balanceleaveTableViewCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var open: UILabel!
    @IBOutlet weak var enjoy: UILabel!
    @IBOutlet weak var closing: UILabel!
   
    func setleave(data: balanceModel)
    {
        type.text = data.type
        open.text = data.opening
        enjoy.text = data.enjoy
        closing.text = data.closing
    }

}
