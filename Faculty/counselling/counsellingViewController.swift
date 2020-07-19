//
//  counsellingViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 09/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class counsellingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let defaultValues = UserDefaults.standard

    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == attendancetbl
        {
            return 3
        }
        else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == attendancetbl
        {
            if(section == 0)
            {
                return 1
            }
            else if(section == 1)
            {
                return studentarray.count
            }
            else
            {
                return subjectArray.count
            }
        }
        else if tableView == resulttbl
        {
            return studentresultarray.count
        }
        else
        {
            return studentfeearray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == attendancetbl
        {
            if(indexPath.section == 0)
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! UITableViewCell
                return cell
            }
            else if(indexPath.section == 1)
            {
                let studentattendancesel = studentarray[indexPath.row]
                
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
        else if tableView == resulttbl
        {
            let studentresultsel = studentresultarray[indexPath.row]
            
            print("Cell...\(String(describing: studentresultsel.monthandyear))")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentSemTableViewCell
            cell.setstudentresultdata(data: studentresultsel)
            
            cell.accessoryType = .disclosureIndicator
            return cell        }
        else
        {
            let studentfee = studentfeearray[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FeesTableViewCell
            cell.setfees(data: studentfee)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == resulttbl
        {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultController") as? ResultController
            let examid = studentresultarray[indexPath.row].examid as! String
            self.defaultValues.set(examid, forKey: "examid")
            vc?.uniqueExamID = studentresultarray[indexPath.row].examid as! String
            vc?.sem = studentresultarray[indexPath.row].sem as! String
            vc?.month = studentresultarray[indexPath.row].monthandyear as! String
            //        vc?.index = indexPath.row as! String
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let screenSize: CGRect = UIScreen.main.bounds
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 30))
         if tableView == attendancetbl{
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
        
        }
        return vw
        
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    var sid : String = ""
    var studname : String = ""
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
//view outlets
    @IBOutlet weak var generalview: UIView!
    @IBOutlet weak var resultvw: UIView!
    @IBOutlet weak var Attendanceview: UIView!
    @IBOutlet weak var Feeview: UIView!

    @IBOutlet weak var segmentedcontrol: UISegmentedControl!
//General view varaibles
    
    @IBOutlet weak var adharnum: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var bldgrp: UILabel!
    @IBOutlet weak var praddress: UITextView!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var pincode: UILabel!
    @IBOutlet weak var prcity: UILabel!
    @IBOutlet weak var prpincode: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var homephn: UILabel!
    @IBOutlet weak var guardian: UILabel!
//Attendance view varaibles
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var sem: UILabel!
    @IBOutlet weak var attendancetbl: UITableView!
    var studentarray : [AttendanceModel] = []
//Result View Variables
    @IBOutlet weak var resulttbl: UITableView!
    var studentresultarray : [ResultModel] = []
    var subjectArray : [subjectmodel] = []

//Fee View variables
    @IBOutlet weak var feetbl: UITableView!
    var studentfeearray : [FeesModel] = []

    
    
    @IBAction func indexchanged(_ sender: Any) {
        switch segmentedcontrol.selectedSegmentIndex
        {
        case 0:
            generalview.isHidden = false
            resultvw.isHidden = true
            Feeview.isHidden = true
            Attendanceview.isHidden = true
            
            
        case 1:
            generalview.isHidden = true
            resultvw.isHidden = false
            Feeview.isHidden = true
            Attendanceview.isHidden = true
        case 2:
            generalview.isHidden = true
            resultvw.isHidden = true
            Feeview.isHidden = false
            Attendanceview.isHidden = true
        case 3:
            generalview.isHidden = true
            resultvw.isHidden = true
            Feeview.isHidden = true
            Attendanceview.isHidden = false
        default:
            print("default")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//General View
        print("name"+"\(User.getstudname())")
        let URL_GET_DATA = "\(webservice.accesskey)"+"getdata.php"
        let params :[String:AnyObject] = ["name" : User.getstudname() as AnyObject]
         name.text = User.getstudname()
         id.text = User.getstudid()
        print(params)
        request(URL_GET_DATA, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            
            response in response
            let jsonResponse = response.result.value as! NSDictionary
            print(jsonResponse)
            
            self.dob.text = jsonResponse["dob"] as! String
            self.city.text = jsonResponse["city"] as! String
            self.address.text = jsonResponse["address"] as! String
            self.praddress.text = jsonResponse["address"] as! String
            self.prcity.text = jsonResponse["city"] as! String
            self.email.text = jsonResponse["mailid"] as! String
            self.mobile.text = jsonResponse["mobnum"] as! String
            self.homephn.text = jsonResponse["mobnum"] as! String
            self.guardian.text = jsonResponse["mobnum"] as! String
            self.pincode.text = jsonResponse["pincode"] as! String
            self.prpincode.text = jsonResponse["pincode"] as! String
            self.adharnum.text = jsonResponse["adharnum"] as! String
            self.bldgrp.text = jsonResponse["bloodgrp"] as! String

            SVProgressHUD.dismiss()
        })
//Result View
        let URL_GET_res = "\(webservice.accesskey)"+"getResultDetails.php"
        let paramsr :[String:AnyObject] = ["sid" : User.getstudid() as AnyObject]
        resulttbl.delegate = self
        resulttbl.dataSource = self
        resulttbl.tableFooterView = UIView()
        request(URL_GET_res, method: .post, parameters: paramsr, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            
            
            let length = jsonResponse.count
            for i in 0...length - 1
            {
                
                let student = jsonResponse[i] as! NSDictionary
                let sem : String = student.value(forKey: "sem") as! String
                let monthYear : String = student.value(forKey: "month&year") as! String
                let examid : String = student.value(forKey: "examid") as! String
                User.setexamid(value: examid)
                let resultModel = ResultModel(sem: sem, coursetype: "", coursecode: "", monthandyear: monthYear, grade: "", credit: "", examid: examid)
                self.studentresultarray.append(resultModel)
                
            }
            self.resulttbl.reloadData()
//            SVProgressHUD.dismiss()
            
        })
// Fee View
        let URL_GET_fee = "\(webservice.accesskey)"+"getFees.php"
        feetbl.delegate = self
        feetbl.dataSource = self
        feetbl.tableFooterView = UIView()
        request(URL_GET_fee, method: .post, parameters: paramsr, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
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
                self.studentfeearray.append(feemodel)
                
            }
            self.feetbl.reloadData()
//            SVProgressHUD.dismiss()
        })
//Attendance View
        let URL_GET_att = "\(webservice.accesskey)"+"getAttendanceDetails.php"
        let params1 : [String:AnyObject] = ["sid" : User.getstudid() as AnyObject]
        let URL_GET_DATA2 = "\(webservice.accesskey)"+"getdata.php"
        let paramsa :[String:AnyObject] = ["name" : User.getstudname() as AnyObject]
        let URL_GET_DATA1 = "\(webservice.accesskey)"+"getattsubject.php"
        print(params1)
        request(URL_GET_DATA2, method: .post, parameters: paramsa, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            
            response in response
            let jsonResponse = response.result.value as! NSDictionary
            print(jsonResponse)
            self.month.text = jsonResponse["year"] as? String
            self.sem.text = jsonResponse["sem"] as? String
        })
        
        request(URL_GET_att, method: .post, parameters: params1, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
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
                self.studentarray.append(attmodel)
                
            }
            self.attendancetbl.reloadData()
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
            self.attendancetbl.reloadData()
            SVProgressHUD.dismiss()
        })
        // Do any additional setup after loading the view.
    }
    

}
