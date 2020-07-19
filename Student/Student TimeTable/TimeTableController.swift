//
//  TimeTableController.swift
//  DemoApp
//
//  Created by Jinal Shah on 14/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit

class TimeTableController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "sname"){
//            lblName.text = name
        } else {
            //send back to login View Controller
            
        }
//        let image : UIImage = UIImage(cgImage: "timetable" as! CGImage)
        img.image = UIImage(named: "timetable")
        
        
//        img.image = image
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
