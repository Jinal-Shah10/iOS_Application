//
//  AttendanceController.swift
//  DemoApp
//
//  Created by Jinal Shah on 14/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class AttendanceController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var studentdataarray: [AttendanceModel] = []
    var subjectArray : [subjectmodel] = []

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        else if(section == 1)
        {
            return studentdataarray.count
        }
        else
        {
            return subjectArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0)
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! UITableViewCell
            
            
            
            return cell
        }
        else if(indexPath.section == 1)
        {
            let studentattendancesel = studentdataarray[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! AttendanceTableViewCell
            cell.setstudentAttendancedata(data: studentattendancesel)
            if(((cell.percentage.text! as NSString).doubleValue) > 50)
             {
                cell.percentage.textColor = UIColor.green;

            }
            else
            {
                cell.percentage.textColor = UIColor.red;
            }
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            
            let subjectsel3 = subjectArray[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! subjectattTableViewCell
            cell.setsubjectcard(data: subjectsel3)
            cell.selectionStyle = .none
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        else{
            return 30.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let screenSize: CGRect = UIScreen.main.bounds
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 30))
        let label = UILabel()
        label.textAlignment = .center
        label.font.withSize(5)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = UIColor(red: 27/255, green: 130/255, blue: 198/255, alpha: 1.0)
        if section == 1 {
            label.text = "Attendance Summary"
        }
        else if section == 2{
            label.text = "Subject Details"

        }
        else {
            label.text = ""
        }
        vw.addSubview(label)
        vw.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[Lbl]-|", options: .alignAllLeft, metrics: nil, views: ["Lbl" : label]))
        vw.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[Lbl]|", options: .alignAllLeft, metrics: nil, views: ["Lbl" : label]))
        return vw
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 60.0
        }
        else{
            return 40.0
        }
    }
    let URL_GET_DATA = "\(webservice.accesskey)"+"getAttendanceDetails.php"
    let URL_GET_DATA1 = "\(webservice.accesskey)"+"getattsubject.php"
    let defaultValues = UserDefaults.standard
  //    let params : Parameters = ["sid" : "s4"]
    let URL_GET_DATA2 = "\(webservice.accesskey)"+"getdata.php"
    let params :[String:AnyObject] = ["name" : User.getdisplayname() as AnyObject]
let params1 : [String:AnyObject] = ["sid" : User.getuserid() as AnyObject]
    
    @IBOutlet weak var tabledata: UITableView!
    
    @IBOutlet weak var lblmonth: UILabel!
    
    @IBOutlet weak var lblsem: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        lblmonth.text = UserDefaults.standard.string(forKey: "year")
//        lblsem.text = UserDefaults.standard.string(forKey: "sem")
//        print(UserDefaults.standard.string(forKey: "year"))
//        print(UserDefaults.standard.string(forKey: "sem"))
        print(params1)
        SVProgressHUD.show(withStatus: "Please Wait")
        let defaultValues = UserDefaults.standard
        lblName.text = User.getdisplayname()
        request(self.URL_GET_DATA2, method: .post, parameters: self.params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            
            response in response
            let jsonResponse = response.result.value as! NSDictionary
            print(jsonResponse)
            self.lblmonth.text = jsonResponse["year"] as? String
            self.lblsem.text = jsonResponse["sem"] as? String
        })
        request(URL_GET_DATA, method: .post, parameters: params1, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
        
        response in response
        let jsonResponse = response.result.value as! NSArray
        print(jsonResponse.count)
        let length = jsonResponse.count
        for i in 0...length - 1 {
            
            let student = jsonResponse[i] as! NSDictionary
            //let subject : String = student.value(forKey: "subject") as! String
            let subcode : String = student.value(forKey: "subject") as! String
            let type : String = student.value(forKey: "classtype") as! String
            let present : String = ((student.value(forKey: "present")as! String)+"/"+(student.value(forKey: "totallectures")as! String))
            let a = (student.value(forKey: "present") as? NSString)!.doubleValue
            let b = (student.value(forKey: "totallectures") as? NSString)!.doubleValue
            let per = (a/b)*100
            let percentage : String = per.toString()
            let attmodel = AttendanceModel(classtype: type, present: present, percentage: per, subcode: subcode)
            self.studentdataarray.append(attmodel)
            
        }
         self.tabledata.reloadData()
    })
        request(URL_GET_DATA1, method: .post, parameters: params1, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                
                let student = jsonResponse[i] as! NSDictionary
                let subname : String = student.value(forKey: "subname") as! String
                let subject : String = student.value(forKey: "subject") as! String
                let subjectsemmodel = subjectmodel(subcode: subject, subname: subname)
                self.subjectArray.append(subjectsemmodel)
            }
            self.tabledata.reloadData()
            SVProgressHUD.dismiss()
        })
    }
    
}

extension Double {
    func toString() -> String{
        return String(format: "%.1f", self)
    }
}
