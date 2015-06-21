//
//  CCDSettingTableViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/20/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class CCDSettingTableViewController: UITableViewController {
    private let viewTitle = "設定"
    private let switchCellIdentifier = "switchCell"
    private let detailCellIdentifier = "detailCell"
    private var twitterId: String? = CCDSetting.sharedInstance().twitterId

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewTitle
        let switchNib = UINib(nibName: "CCDSwitchTableViewCell", bundle: nil)
        tableView.registerNib(switchNib, forCellReuseIdentifier: switchCellIdentifier)
        let detailNib = UINib(nibName: "CCDDetailTableViewCell", bundle: nil)
        tableView.registerNib(detailNib, forCellReuseIdentifier: detailCellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if CCDSetting.sharedInstance().useTwitter {
            return CCDSettingTableList.sharedInstance().settingTitleList.count
        } else {
            return CCDSettingTableList.sharedInstance().settingTitleList.count - 1
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if !CCDSetting.sharedInstance().useLaboLocate {
                return 1
            }
        case 1:
            if !CCDSetting.sharedInstance().useTwitter {
                return 1
            }
        case 2:
            if !CCDSetting.sharedInstance().useLaboridaChallenge {
                return 1
            }
        default:
            break
        }
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
        }

        cell.selectionStyle = .None

        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            (cell as! CCDSwitchTableViewCell).switchToSetting.on = CCDSetting.sharedInstance().useLaboLocate
            (cell as! CCDSwitchTableViewCell).switchToSetting.tag = 0
            (cell as! CCDSwitchTableViewCell).switchToSetting.addTarget(self, action: "valueChangedSwitch:", forControlEvents: .ValueChanged)
        case (1, 0):
            (cell as! CCDSwitchTableViewCell).switchToSetting.on = CCDSetting.sharedInstance().useTwitter
            (cell as! CCDSwitchTableViewCell).switchToSetting.tag = 1
            (cell as! CCDSwitchTableViewCell).switchToSetting.addTarget(self, action: "valueChangedSwitch:", forControlEvents: .ValueChanged)
        case (1, 1):
            setTwitterId((cell as! CCDDetailTableViewCell))
        case (2, 0):
            (cell as! CCDSwitchTableViewCell).switchToSetting.on = CCDSetting.sharedInstance().useLaboridaChallenge
            (cell as! CCDSwitchTableViewCell).switchToSetting.tag = 2
            (cell as! CCDSwitchTableViewCell).switchToSetting.addTarget(self, action: "valueChangedSwitch:", forControlEvents: .ValueChanged)
        default:
            break
        }

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CCDSettingTableList.sharedInstance().settingTitleList[section]
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 1):
            return
        case (0, 2):
            return
        case (0, 3):
            return
        case (0, 4):
            return
        case (1, 1):
            let twitterModel = CCDTwitterModel()
            twitterModel.login()
            return
        case (2, 1):
            return
        default:
            return
        }
    }

    func valueChangedSwitch(sender: UISwitch) {

        tableView.beginUpdates()
        switch sender.tag {
        case 0:
            if sender.on != CCDSetting.sharedInstance().useLaboLocate {
                CCDSetting.sharedInstance().useLaboLocate = sender.on
                var indexPaths = [NSIndexPath]()
                for i in 1 ..< CCDSettingTableList.sharedInstance().settingList[0].count {
                    indexPaths.append(NSIndexPath(forRow: 1, inSection: 0))
                }
                if sender.on == true {
                    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
                } else {
                    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
                }
            }
        case 1:
            if sender.on != CCDSetting.sharedInstance().useTwitter {
                CCDSetting.sharedInstance().useTwitter = sender.on
                var indexPaths = [NSIndexPath]()
                for i in 1 ..< CCDSettingTableList.sharedInstance().settingList[1].count {
                    indexPaths.append(NSIndexPath(forRow: i, inSection: 1))
                }
                if sender.on == true {
                    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
                    tableView.insertSections(NSIndexSet(index: 2), withRowAnimation: .Fade)
                } else {
                    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
                    tableView.deleteSections(NSIndexSet(index: 2), withRowAnimation: .Fade)
                }
            }
        case 2:
            if sender.on != CCDSetting.sharedInstance().useLaboridaChallenge {
                CCDSetting.sharedInstance().useLaboridaChallenge = sender.on
                var indexPaths = [NSIndexPath]()
                for i in 1 ..< CCDSettingTableList.sharedInstance().settingList[2].count {
                    indexPaths.append(NSIndexPath(forRow: i, inSection: 2))
                }
                if sender.on == true {
                    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
                } else {
                    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
                }
            }
        default:
            break
        }
        tableView.endUpdates()
    }

    func setTwitterId(cell: CCDDetailTableViewCell?) {
        let twitterIdCell = cell ?? tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: NSIndexPath(forRow: 1, inSection: 1)) as! CCDDetailTableViewCell
        if let twitterId = CCDSetting.sharedInstance().twitterId {
            twitterIdCell.labelToShowCurrentSetting.text = "@\(twitterId)"
        } else {
            twitterIdCell.labelToShowCurrentSetting.text = "設定なし"
        }
    }
}
