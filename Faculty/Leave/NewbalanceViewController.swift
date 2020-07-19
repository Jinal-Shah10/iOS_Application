//
//  NewbalanceViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 15/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD
import SwiftyPickerPopover

class NewbalanceViewController: UIViewController {
    
    let url = "\(webservice.accesskey)"+"newLeave.php"
    let url1 = "\(webservice.accesskey)"+"getleaveBalance.php"
    var picker = UIPickerView()
    var leavetype = ["CL","AOD","Single","DL-E"]
    var type = ["Full Day","First half","Second half"]
    var params : [String:AnyObject] = ["":"" as AnyObject]
    
    
    private var selectedRow: Int = 0
    @IBOutlet weak var noOfDaystxt: UITextField!
    
    @IBOutlet weak var fromtype: UITextField!
    
    @IBOutlet weak var totype: UITextField!
    
    @IBOutlet weak var reasonView: UITextView!
    @IBOutlet weak var txtEnjoyed: UITextField!
    @IBOutlet weak var txtbalance: UITextField!
        
    @IBOutlet weak var toDate: UITextField!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var leaveType: UITextField!
    @IBOutlet weak var lbluser: UILabel!
    
    
    @IBAction func fromedit(_ sender: Any) {
//        view.endEditing(true)
        DatePickerPopover(title: "Date Picker")
            .setDateMode(.date)
            .setSelectedDate(Date())
            .setDoneButton(action: { popover, selectedRow in print("selecedDate \(selectedRow)")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let finTime = dateFormatter.string(from: selectedRow)
                self.fromDate.text = finTime
                print(self.fromDate)
            })
            .setCancelButton(action: { _, _ in print("cancel")})
            .appear(originView: sender as! UIView, baseViewController: self)
       
    }
    
    @IBAction func toedit(_ sender: Any) {
//        view.endEditing(true)
        DatePickerPopover(title: "Date Picker")
            .setDateMode(.date)
            .setSelectedDate(Date())
            .setDoneButton(action: { popover, selectedRow in print("selecedDate \(selectedRow)")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let finTime = dateFormatter.string(from: selectedRow)
                self.toDate.text = finTime
                //
                print(self.toDate)
            })
            .setCancelButton(action: { _, _ in print("cancel")})
            .appear(originView: sender as! UIView, baseViewController: self)
        
    }
    
    @IBAction func fromtype(_ sender: Any) {

//        view.endEditing(true)
        StringPickerPopover(title: "StringPicker", choices: ["Full Day" , "First Half" , "Second half"]).setSelectedRow(0).setDoneButton(action: {(popover, selectedRow, selectedString) in
            print("done row \(selectedRow) \(selectedString)")
            
            self.fromtype.text = selectedString
        }).setCancelButton(action: {(_, _, _)in print("cancel")}).appear(originView: sender as! UIView, baseViewController: self)
        
    }
    

    @IBAction func totype(_ sender: Any) {

//        view.endEditing(true)
        StringPickerPopover(title: "StringPicker", choices: ["Full Day" , "First Half" , "Second half" ])
            .setSelectedRow(0)
            .setDoneButton(action: {(popover, selectedRow, selectedString) in
            print("done row \(selectedRow) \(selectedString)")
            self.totype.text = selectedString
                    })
            .setCancelButton(action: {(_, _, _)in print("cancel")})
            .appear(originView: sender as! UIView, baseViewController: self)
        
        
    }
    
    @IBAction func typeedit(_ sender: Any) {
//        view.endEditing(true)
        StringPickerPopover(title: "StringPicker", choices: ["CL","AOD","Single","DL-E"])
            .setSelectedRow(0)
            .setDoneButton(action: {(popover, selectedRow, selectedString) in
                        print("done row \(selectedRow) \(selectedString)")
                    self.leaveType.text = selectedString
                
                if(self.leaveType.text == "CL")
                {
                    self.noOfDaystxt.text = "1"
                }
                else if(self.leaveType.text == "AOD")
                {
                    self.noOfDaystxt.text = "1"
                }
                else if(self.leaveType.text == "SL")
                {
                    self.noOfDaystxt.text = "1"
                }
                else
                {
                    self.noOfDaystxt.text = "1"
                }
                var params1 : [String:AnyObject] = ["type": self.leaveType!.text as AnyObject  ]
                request(self.url1, method: .post, parameters: params1, encoding: URLEncoding.httpBody, headers:nil).responseJSON(completionHandler: {
                    response in response
                    let jsonResponse = response.result.value as! NSArray
                    print(jsonResponse.count)
                    print(jsonResponse)
                    let length = jsonResponse.count
                    for i in 0...length - 1 {
                        let student = jsonResponse[i] as! NSDictionary
                        self.txtbalance.text = (student.value(forKey: "closebal") as? String)
                        self.txtEnjoyed.text = (student.value(forKey: "enjoy") as? String)
//                        let todate : String = student.value(forKey: "today") as! String
//                        let status : String = student.value(forKey: "status") as! String
                        
//                        self.txtBalance.text = "\(student["closebal"]!)"
                      
                    }
                })
                
                    })
            .setCancelButton(action: {(_, _, _)in print("cancel")}).appear(originView: sender as! UIView, baseViewController: self)
       
    }
    
    
    
    @IBOutlet weak var submit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reasonView.layer.borderColor = UIColor.lightGray.cgColor
        self.reasonView.layer.borderWidth = 1
        self.reasonView.clipsToBounds = true
        self.reasonView.layer.cornerRadius = 10.0
       
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewbalanceViewController.viewTapped(gestureRecogniser:)))
        view.addGestureRecognizer(tapGesture)
  
        let name = User.getdisplayname()
            lbluser.text = name
       self.submit.layer.cornerRadius = 12 
        
    }
    
    
    @IBAction func submitButton(_ sender: Any) {
        print("button click....")
        params = ["empid" : "\(User.getuserid())" as String,"from" : "\(fromDate.text!)" as String , "to" : "\(toDate.text!)" as String , "type" : "\(leaveType.text!)" as String , "reason" : "\(reasonView.text!)" as String , "status" : "Pending" as String] as [String : AnyObject]
        print(params)
        request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "toStatus") as! balancestatusViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
         performSegue(withIdentifier: "toStatus", sender: self)
    }
    
    @objc func viewTapped(gestureRecogniser: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(selectedRow: Date){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        fromDate.text = dateFormatter.string(from: selectedRow)
        print(fromDate)
        view.endEditing(true)
        
    }
   
   
}
