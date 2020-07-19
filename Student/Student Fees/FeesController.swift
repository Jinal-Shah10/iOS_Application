//
//  FeesController.swift
//  DemoApp
//
//  Created by Jinal Shah on 14/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class FeesController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var Feesarray : [FeesModel] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       SVProgressHUD.show(withStatus: "Please Wait")
        return Feesarray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentfee = Feesarray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FeesTableViewCell
        cell.setfees(data: studentfee)
        cell.selectionStyle = .none
        
        return cell
    }
    let URL_GET_DATA = "\(webservice.accesskey)"+"getFees.php"
    let defaultValues = UserDefaults.standard
let params :[String:AnyObject] = ["sid" : User.getuserid() as AnyObject]
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tbldata: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbldata.delegate = self
        tbldata.dataSource = self
         tbldata.tableFooterView = UIView()
        lblName.text = User.getdisplayname()
        request(URL_GET_DATA, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            print(jsonResponse)
            let length = jsonResponse.count
            for i in 0...length - 1 { 
                let student = jsonResponse[i] as! NSDictionary
                let sem : String = student.value(forKey: "sem") as! String
                let total : String = student.value(forKey: "totalfees") as! String
                let received : String = student.value(forKey: "receivedfees") as! String
                let pending : String = student.value(forKey: "pendingfees") as! String
                let feemodel = FeesModel(sid: nil, sem: sem, totalfees: total, receivedfees: received, pendingfees: pending)
                self.Feesarray.append(feemodel)
                
            }
            self.tbldata.reloadData()
            SVProgressHUD.dismiss()
        })
    
    }
    
}
