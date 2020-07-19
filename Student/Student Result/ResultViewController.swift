//
//  ResultViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 22/03/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ResultViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    let URL_GET_DATA = "\(webservice.accesskey)"+"getResultDetails.php"
    let defaultValues = UserDefaults.standard
    let params :[String:AnyObject] = ["sid" : User.getuserid() as AnyObject]
    var studentdataarray: [ResultModel] = []
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SVProgressHUD.show(withStatus: "Please Wait")
        return studentdataarray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let studentresultsel = studentdataarray[indexPath.row]
        
        print("Cell...\(String(describing: studentresultsel.monthandyear))")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentSemTableViewCell
        cell.setstudentresultdata(data: studentresultsel)
       
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultController") as? ResultController
        let examid = studentdataarray[indexPath.row].examid as! String
        User.setexamid(value: examid)
        vc?.uniqueExamID = studentdataarray[indexPath.row].examid as! String
        vc?.sem = studentdataarray[indexPath.row].sem as! String
        vc?.month = studentdataarray[indexPath.row].monthandyear as! String
//        vc?.index = indexPath.row as! String
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    @IBOutlet weak var lbluser: UILabel!
    
    @IBOutlet weak var tbldata: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultValues = UserDefaults.standard
        if let name = User.getuserid() as? String{
         
        lbluser.text = name
        tbldata.delegate = self
        tbldata.dataSource = self
        tbldata.tableFooterView = UIView()
        print(params)
        request(URL_GET_DATA, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: {
            
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
                let resultModel = ResultModel(sem: sem, coursetype: "", coursecode: "", monthandyear: monthYear, grade: "", credit: "", examid: examid)
                self.studentdataarray.append(resultModel)

            }
            self.tbldata.reloadData()
            SVProgressHUD.dismiss()
         
        })

        // Do any additional setup after loading the view.
    }
    

    

}
}
