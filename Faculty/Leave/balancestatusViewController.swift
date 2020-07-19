//
//  balancestatusViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 15/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class balancestatusViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SVProgressHUD.show(withStatus: "Please Wait")
        return statusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fstatus = statusArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! balancestatusTableViewCell
        cell.setstatus(data: fstatus)
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "toleaveinformation", sender: self)
    }
    
    var statusArray : [statusModel] = []
    
    @IBOutlet weak var tblstatus: UITableView!
    
    let URL_GET_DATA = "\(webservice.accesskey)"+"getleaveDetails.php"
    let defaultValues = UserDefaults.standard
    let params :[String:AnyObject] = ["empid" : User.getuserid() as AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblstatus.delegate = self
        tblstatus.dataSource = self
        tblstatus.tableFooterView = UIView()
        //        lblName.text = User.getdisplayname()
        request(URL_GET_DATA, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            print(jsonResponse)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                let student = jsonResponse[i] as! NSDictionary
                let leave : String = student.value(forKey: "leaveid") as! String
                let type : String = student.value(forKey: "type") as! String
                let fromdate : String = student.value(forKey: "fromdate") as! String
                let todate : String = student.value(forKey: "today") as! String
                let status : String = student.value(forKey: "status") as! String
                User.setleaveid(value: leave)
                let statusbl = statusModel(fromdate: fromdate, todate: todate, type: type, status: status)
                self.statusArray.append(statusbl)
                print("leave id....."+User.getleaveid())
            }
            self.tblstatus.reloadData()
            SVProgressHUD.dismiss()
        })
       
    }
    

    

}
