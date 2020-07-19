//
//  GeneralInfo.swift
//  DemoApp
//
//  Created by Jinal Shah on 09/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class GeneralInfo: UIView {
    
    
    
    
    
    
    
    let URL_GET_DATA = "http://192.168.154.136/MyWebService/api/getdata.php"
    let defaultValues = UserDefaults.standard
    let name = UserDefaults.standard.string(forKey: "sname")
    let params :[String:AnyObject] = ["name" : UserDefaults.standard.string(forKey: "sname") as AnyObject]
    
    
    
    
}
