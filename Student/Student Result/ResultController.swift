//
//  ResultController.swift
//  DemoApp
//
//  Created by Jinal Shah on 14/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ResultController: UIViewController,UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblid: UILabel!
    @IBOutlet weak var lblsem: UILabel!
    @IBOutlet weak var lblmon: UILabel!
    

    var resultSemArray : [ResultModel] = []
    var subjectArray : [subjectmodel] = []
    
    var uniqueExamID : String = ""
    var sem : String = ""
    var month : String = ""

    var index : String = ""
    

    @IBOutlet weak var tablev: UITableView!
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0)
        {
            return 1
        }
        else if(section == 1)
        {
            return resultSemArray.count
        }
        else if(section == 2)
        {
            return 1
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
            let studentresultsel = resultSemArray[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as!StudentResultTableViewCell
            
//            cell.code.text = "CA836"
//            cell.type.text = "Practical"
//            cell.credit.text = "4.0"
//            cell.grade.text = "AA"
            cell.setresultcard(data: studentresultsel)
            cell.selectionStyle = .none
            return cell
        }
        else if(indexPath.section == 2)
        {
//            let subjectsel = subjectArray[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! ResultTableViewCell
            cell.total.text = "25"
            cell.credits.text = "23"
            cell.sgpa.text = "9.23"
            return cell
        }
        else 
        {
            let subjectsel3 = subjectArray[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as! SubjectTableViewCell
            cell.setsubjectcard(data: subjectsel3)
            cell.selectionStyle = .none
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2{
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
        if section == 0 {
            label.text = "Results"
        }
        else if section == 3 {
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
        if indexPath.section == 2{
            return 80.0
        }
        else if indexPath.section == 3{
            return 50.0
        }
        else{
            return 40.0
        }
    }
    let URL_GET_DATA = "\(webservice.accesskey)"+"getResult.php"
    let URL_GET_DATA1 = "\(webservice.accesskey)"+"getSubject.php"

    let defaultValues = UserDefaults.standard
    
//    let params1 : [String:AnyObject] = ["sid" : UserDefaults.standard.string(forKey: "email") as AnyObject]

    @IBOutlet weak var lblName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let params :[String:AnyObject] = ["examid" : User.getexamid() as AnyObject]
        tablev.delegate = self
        tablev.dataSource = self
        tablev.tableFooterView = UIView()
        User.setexamid(value: uniqueExamID)
        lblsem.text = self.sem
        lblmon.text = self.month
        lblid.text = User.getstudid()
        lblname.text = User.getstudname()
        print(params)
        request(URL_GET_DATA, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                
                let student = jsonResponse[i] as! NSDictionary
                let coursetype : String = student.value(forKey: "coursetype") as! String
                let coursecode : String = student.value(forKey: "subcode") as! String
                let grade : String = student.value(forKey: "grade") as! String
                let credit  : String = student.value(forKey: "credit") as! String
                let resultSemModel = ResultModel(sem: nil, coursetype: coursetype , coursecode: coursecode , monthandyear: nil, grade: grade , credit: credit ,examid: nil)
                self.resultSemArray.append(resultSemModel)
            
            }
            self.tablev.reloadData()
            
        })
        request(URL_GET_DATA1, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            response in response
            let jsonResponse = response.result.value as! NSArray
            print(jsonResponse.count)
            let length = jsonResponse.count
            for i in 0...length - 1 {
                
                let student = jsonResponse[i] as! NSDictionary
                let subname : String = student.value(forKey: "subname") as! String
                let coursecode : String = student.value(forKey: "subcode") as! String
               let subjectsemmodel = subjectmodel(subcode: coursecode, subname: subname)
                self.subjectArray.append(subjectsemmodel)
            }
            self.tablev.reloadData()
        })
    }
}

