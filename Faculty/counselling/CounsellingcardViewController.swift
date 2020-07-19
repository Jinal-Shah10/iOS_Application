//
//  CounsellingcardViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 09/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD



class CounsellingcardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var counsellingarray : [counsellingModel] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SVProgressHUD.show(withStatus: "Please Wait")
        return counsellingarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let counsellingdata = counsellingarray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CounsellingcardTableViewCell
        cell.setstudents(data: counsellingdata)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tocounsellingviewcontroller") as? counsellingViewController
        let sid = counsellingarray[indexPath.row].sid as! String
        User.setstudid(value: sid)
        vc?.sid = counsellingarray[indexPath.row].sid as! String
         let stdname = counsellingarray[indexPath.row].name as! String
        vc?.studname = counsellingarray[indexPath.row].name as! String
       User.setstudname(value: stdname)
//        vc?.sem = studentdataarray[indexPath.row].sem as! String
//        vc?.month = studentdataarray[indexPath.row].monthandyear as! String
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    let URL_GET_DATA = "\(webservice.accesskey)"+"getCounsellorDetails.php"
    let defaultValues = UserDefaults.standard
    let params :[String:AnyObject] = ["empid" : User.getuserid() as AnyObject]
    
    @IBOutlet weak var tbldata: UITableView!
    
    @IBOutlet weak var search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbldata.delegate = self
        tbldata.dataSource = self
        tbldata.tableFooterView = UIView()
        

        print(params)
        request(URL_GET_DATA, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            print(jsonResponse)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                let student = jsonResponse[i] as! NSDictionary
                let sid : String = student.value(forKey: "sid") as! String
                let name : String = student.value(forKey: "same") as! String
                let city : String = student.value(forKey: "city") as! String
                let mobile : String = student.value(forKey: "mobnum") as! String
                let counsellingmodel = counsellingModel(sid: sid, name: name, city: city, mobnum: mobile)
                self.counsellingarray.append(counsellingmodel)
                
            }
            self.tbldata.reloadData()
            SVProgressHUD.dismiss()
        })
        
        

    }
    

}

