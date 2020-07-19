//
//  balanceleaveViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 15/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class balanceleaveViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var balanceArray : [balanceModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SVProgressHUD.show(withStatus: "Please Wait")
        return balanceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fleave = balanceArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! balanceleaveTableViewCell
        cell.setleave(data: fleave)
        cell.selectionStyle = .none
        
        return cell
    }
    
    let URL_GET_DATA = "\(webservice.accesskey)"+"getleaveDetails.php"
    let defaultValues = UserDefaults.standard
    let params :[String:AnyObject] = ["empid" : User.getuserid() as AnyObject]

    
    @IBOutlet weak var tblbal: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblbal.delegate = self
        tblbal.dataSource = self
        tblbal.tableFooterView = UIView()
//        lblName.text = User.getdisplayname()
        request(URL_GET_DATA, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            print(jsonResponse)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                let student = jsonResponse[i] as! NSDictionary
                let type : String = student.value(forKey: "type") as! String
                let enjoy : String = student.value(forKey: "enjoy") as! String
                let opening : String = student.value(forKey: "openbal") as! String
                let closing : String = student.value(forKey: "closebal") as! String
                let balancele = balanceModel(type: type, enjoy: enjoy, opening: opening, closing: closing)
                self.balanceArray.append(balancele)
                
            }
            self.tblbal.reloadData()
            SVProgressHUD.dismiss()
        })
        
       
    }
    
}
