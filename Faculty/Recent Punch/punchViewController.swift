//
//  punchViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 17/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class punchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var punchArray : [punchModel] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SVProgressHUD.show(withStatus: "Please Wait")
        return punchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fpunch = punchArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! punchTableViewCell
        cell.setpunch(data: fpunch)
        cell.selectionStyle = .none
        
        return cell
    }
    let URL_GET_DATA = "\(webservice.accesskey)"+"getPunch.php"
    let defaultValues = UserDefaults.standard
//    let params :[String:AnyObject] = ["empid" : User.getuserid() as AnyObject]
    @IBOutlet weak var tbldata: UITableView!
    
    @IBOutlet weak var name: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbldata.delegate = self
        tbldata.dataSource = self
        tbldata.tableFooterView = UIView()
        name.text = User.getdisplayname()
        request(URL_GET_DATA, method: .post, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            print(jsonResponse)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                let student = jsonResponse[i] as! NSDictionary
                let inpunch : String = student.value(forKey: "inpunch") as! String
                let pdate : String = student.value(forKey: "edate") as! String
                let outpunch : String = student.value(forKey: "outpunch") as! String
                let statusbl = punchModel(pdate: pdate , inpunch: inpunch, outpunch: outpunch)
                self.punchArray.append(statusbl)
                
            }
            self.tbldata.reloadData()
            SVProgressHUD.dismiss()
        })
        // Do any additional setup after loading the view.
    }
    


}
