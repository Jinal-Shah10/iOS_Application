//
//  Profielcontroller.swift
//  DemoApp
//
//  Created by Jinal Shah on 07/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import MessageUI

class Profilecontroller: UIViewController , MFMailComposeViewControllerDelegate
{
    

    let URL_GET_DATA = "\(webservice.accesskey)"+"getdata.php"
    let defaultValues = UserDefaults.standard
    let name = User.getdisplayname()
    let params :[String:AnyObject] = ["name" : User.getdisplayname() as AnyObject]
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblBloodGrp: UILabel!
    @IBOutlet weak var lblAdharnum: UILabel!
    @IBOutlet weak var lblCname: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblMobNo: UILabel!
    @IBOutlet weak var lblExtNum: UILabel!
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func emailclick(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["ved.ios@yopmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
  
    @IBAction func mobileclick(_ sender: UIButton) {
        if let url = URL(string: "tel://\(lblMobNo.text)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func extclick(_ sender: UIButton) {
        if let url = URL(string: "tel://\(lblExtNum.text)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     SVProgressHUD.show(withStatus: "Please Wait")
        
            
        print(self.name)
        
            request(self.URL_GET_DATA, method: .post, parameters: self.params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            
response in response
            let jsonResponse = response.result.value as! NSDictionary
            print(jsonResponse)
            self.lblDOB.text = jsonResponse["dob"] as! String
            self.lblname.text = jsonResponse["same"] as! String
            self.lblID.text = jsonResponse["sid"] as! String
            self.lblCname.text = jsonResponse["cname"] as! String
            self.lblemail.text = jsonResponse["mailid"] as! String
            self.lblMobNo.text = jsonResponse["mobnum"] as! String
            self.lblExtNum.text = jsonResponse["extnum"] as! String
            self.lblAdharnum.text = jsonResponse["adharnum"] as! String
            self.lblBloodGrp.text = jsonResponse["bloodgrp"] as! String
            let id = self.lblID.text
            SVProgressHUD.dismiss()
        })
    
    }
}

extension String : ParameterEncoding{
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
    
    
}
