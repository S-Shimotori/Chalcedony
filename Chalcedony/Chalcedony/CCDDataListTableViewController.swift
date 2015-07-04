//
//  CCDDataListTableViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 7/3/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit
import RealmSwift

class CCDDataListTableViewController: UITableViewController {
    private let dataListCellIdentifier = "dataListCellIdentifier"
    private let dateFormatter = NSDateFormatter()
    private var dataSet: [(laboin: NSDate, laborida: NSDate, howLongStayLabo: NSTimeInterval)] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CCDDataListTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: dataListCellIdentifier)

        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .MediumStyle
        let realm = Realm()
        let datas = realm.objects(CCDDataRealmModel)
        for data in datas {
            let laboin = data.laboinDate
            let laborida = data.laboridaDate
            let howLongStayLabo = data.laboridaDate.timeIntervalSinceDate(data.laboinDate)
            dataSet.append((laboin: laboin, laborida: laborida, howLongStayLabo: howLongStayLabo))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(dataListCellIdentifier, forIndexPath: indexPath) as! CCDDataListTableViewCell
        updateCell(cell, indexPath: indexPath)
        return cell
    }

    func updateCell(cell: CCDDataListTableViewCell, indexPath: NSIndexPath) {
        cell.labelToShowLaboinDate.text = dateFormatter.stringFromDate(dataSet[indexPath.row].laboin)
        cell.labelToShowLaboridaDate.text = dateFormatter.stringFromDate(dataSet[indexPath.row].laborida)

        let howLongStayLabo = dataSet[indexPath.row].howLongStayLabo.convertToShow()
        cell.labelToShowHowLongStayLabo.text =
            "\(howLongStayLabo.day)日\(howLongStayLabo.hour)時間\(howLongStayLabo.minute)分\(Int(howLongStayLabo.second))秒"
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
}
