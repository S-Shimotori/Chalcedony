//
//  CCDDataViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/19/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit
import RealmSwift

class CCDDataViewController: UIViewController {
    private let pageTitle = "データ"
    private let dateFormatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = pageTitle

        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .MediumStyle
        let realm = Realm()
        let datas = realm.objects(CCDDataRealmModel)
        for data in datas {
            println("\(dateFormatter.stringFromDate(data.laboinDate)) -> \(dateFormatter.stringFromDate(data.laboridaDate))")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
