//
//  CCDSettingTableViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/20/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class CCDSettingTableViewController: UITableViewController {

    private let switchCellIdentifier = "switchCell"
    private let detailCellIdentifier = "detailCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CCDSwitchTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: switchCellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return CCDSettingTableList.sharedInstance().settingTitleList.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CCDSettingTableList.sharedInstance().settingList[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCellWithIdentifier(switchCellIdentifier, forIndexPath: indexPath) as! CCDSwitchTableViewCell
            (cell as! CCDSwitchTableViewCell).labelToSetting.text = CCDSettingTableList.sharedInstance().settingList[indexPath.section][indexPath.row]
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = CCDSettingTableList.sharedInstance().settingList[indexPath.section][indexPath.row]
        }

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CCDSettingTableList.sharedInstance().settingTitleList[section]
    }

}
