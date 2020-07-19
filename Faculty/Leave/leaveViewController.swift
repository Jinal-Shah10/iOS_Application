//
//  leaveViewController.swift
//  DemoApp
//
//  Created by Jinal Shah on 15/04/19.
//  Copyright © 2019 Jinal Shah. All rights reserved.
//
import UIKit
import Alamofire
import SVProgressHUD
import SwiftyNotifications

class leaveViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    var arrimg = [#imageLiteral(resourceName: "106-512"),#imageLiteral(resourceName: "images"),#imageLiteral(resourceName: "calendar")]
    var arrlbl = ["New Leave","Balance Leave","Leave Status"]

    @IBOutlet weak var colct: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: width / 2, height: 165)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.colct.collectionViewLayout = layout
        
        colct.delegate = self
        colct.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print (arrlbl.count)
        return arrimg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:leaveCollectionViewCell = colct.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! leaveCollectionViewCell
        cell.img.image = arrimg[indexPath.row]
        cell.lbl.text = arrlbl[indexPath.row]
        print(indexPath.row)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select...\(indexPath.row)")
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "tonewleave", sender: self)
            
        case 1:
            print("Result")
            performSegue(withIdentifier: "tobalanceleave", sender: self)
        case 2:
            performSegue(withIdentifier: "toleavestatus", sender: self)
            //            case 3:
            //                performSegue(w©ithIdentifier: "toTimeTableViewController", sender: self)
            //            case 4:
            //                performSegue(withIdentifier: "toAttendanceController", sender: self)
            //            case 5:
        //                performSegue(withIdentifier: "toAboutCharusat", sender: self)
        default:
            print("default")
        }
    }
  
}
