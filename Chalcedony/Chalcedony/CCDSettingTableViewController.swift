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
    private var twitterId: String? = CCDSetting.sharedInstance().twitterId

    override func viewDidLoad() {
        super.viewDidLoad()

        let switchNib = UINib(nibName: "CCDSwitchTableViewCell", bundle: nil)
        tableView.registerNib(switchNib, forCellReuseIdentifier: switchCellIdentifier)
        let detailNib = UINib(nibName: "CCDDetailTableViewCell", bundle: nil)
        tableView.registerNib(detailNib, forCellReuseIdentifier: detailCellIdentifier)
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
            cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: indexPath) as! CCDDetailTableViewCell
            (cell as! CCDDetailTableViewCell).labelToSetting.text = CCDSettingTableList.sharedInstance().settingList[indexPath.section][indexPath.row]
            if indexPath.section == 0 && indexPath.row == 1 {
                (cell as! CCDDetailTableViewCell).labelToShowCurrentSetting.text = CCDSetting.sharedInstance().twitterId
            }
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            setTwitterId((cell as! CCDDetailTableViewCell))
        }
        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CCDSettingTableList.sharedInstance().settingTitleList[section]
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 1):
            let twitterModel = CCDTwitterModel()
            twitterModel.login()
            return
        case (0, 2):
            return
        case (0, 3):
            return
        case (0, 4):
            return
        case (1, 1):
            return
        case (2, 1):
            return
        default:
            return
        }
    }

    func setTwitterId(cell: CCDDetailTableViewCell?) {
        let twitterIdCell = cell ?? tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: NSIndexPath(forRow: 1, inSection: 0)) as! CCDDetailTableViewCell
        if let twitterId = CCDSetting.sharedInstance().twitterId {
            twitterIdCell.labelToShowCurrentSetting.text = "@\(twitterId)"
        } else {
            twitterIdCell.labelToShowCurrentSetting.text = "設定なし"
        }
    }
}
