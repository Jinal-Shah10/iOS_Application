//
//  ResultdetailTableViewCell.swift
//  DemoApp
//
//  Created by Jinal Shah on 09/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit

class ResultdetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sem: UILabel!
    
    @IBOutlet weak var month: UILabel!
    
    func setstudentresultdata (data: ResultModel)
    {
        month.text = data.monthandyear
        sem.text = data.sem
    }
}
