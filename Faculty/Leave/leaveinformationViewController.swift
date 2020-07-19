//
//  leaveinformationViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 17/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SVProgressHUD


class leaveinformationViewController: UIViewController {

    @IBOutlet weak var fromd: UILabel!
    @IBOutlet weak var tod: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var reason: UITextView!
    
    
    let URL_GET_DATA = "\(webservice.accesskey)"+"getleaveDetails.php"
    let defaultValues = UserDefaults.standard
    let params :[String:AnyObject] = ["empid" : User.getuserid() as AnyObject]
    let URL_GET_DATA1 = "\(webservice.accesskey)"+"getleaveinfo.php"
    let params1 :[String:AnyObject] = ["leaveid" : User.getleaveid() as AnyObject]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        request(URL_GET_DATA, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            print(jsonResponse)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                let student = jsonResponse[i] as! NSDictionary
                self.type.text = student.value(forKey: "type") as? String
                self.fromd.text = student.value(forKey: "fromdate") as? String
                self.tod.text = student.value(forKey: "today") as? String
                self.status.text = student.value(forKey: "status") as? String
                self.balance.text = student.value(forKey: "closebal") as? String
              
                
            }
            
        })
        print(params1)
        request(URL_GET_DATA1, method: .post, parameters: params1, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            print(jsonResponse)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                let student = jsonResponse[i] as! NSDictionary
                self.days.text = student.value(forKey: "days") as! String

                self.reason.text = student.value(forKey: "Reason") as! String
            }

        })
    }
    

}
