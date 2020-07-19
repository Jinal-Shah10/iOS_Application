//
//  FacultyProfileViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 08/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class FacultyProfileViewController: UIViewController {

    let URL_GET_DATA = "\(webservice.accesskey)"+"getfacultydata.php"
    let URL_GET_DATA1 = "\(webservice.accesskey)"+"getbankdetails.php"
    let defaultValues = UserDefaults.standard
    let name = User.getdisplayname()
    let params :[String:AnyObject] = ["name" : User.getsystemid() as AnyObject]
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Empid: UILabel!
    @IBOutlet weak var Adharnum: UILabel!
    @IBOutlet weak var joindate: UILabel!
    @IBOutlet weak var passno: UILabel!
    @IBOutlet weak var expdate: UILabel!
    @IBOutlet weak var panno: UILabel!
    @IBOutlet weak var uanno: UILabel!
    @IBOutlet weak var pfno: UILabel!
    @IBOutlet weak var bname: UILabel!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var ifsc: UILabel!
    @IBOutlet weak var accno: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Please Wait")
        
        print(self.params)
        print(self.name)
        
        request(self.URL_GET_DATA, method: .post, parameters: self.params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            
            response in response
            let jsonResponse = response.result.value as! NSDictionary
            print(jsonResponse)
            self.Name.text = jsonResponse["Name"] as! String
            self.Empid.text = jsonResponse["empid"] as? String
            self.Adharnum.text = jsonResponse["adharnum"] as! String
            self.joindate.text = jsonResponse["jdate"] as! String
            self.passno.text = jsonResponse["pno"] as! String
            self.expdate.text = jsonResponse["pexpdate"] as! String
            self.panno.text = jsonResponse["panno"] as! String
            self.uanno.text = jsonResponse["uanno"] as! String
            self.pfno.text = jsonResponse["pfno"] as! String
           
            
        })
        request(self.URL_GET_DATA1, method: .post, parameters: self.params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                let student = jsonResponse[i] as! NSDictionary
            self.bname.text = student.value(forKey:"BankName") as! String
            self.code.text = student.value(forKey:"BranchCode") as! String
            self.ifsc.text = student.value(forKey:"IFSCCode") as! String
            self.accno.text = student.value(forKey:"AccountNo") as! String
            }
            SVProgressHUD.dismiss()
        })
    }

       
    }
    

   


