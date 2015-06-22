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

    @IBOutlet private weak var switchToUseLaboLocate: UISwitch!
    @IBOutlet private weak var switchToUseTwitter: UISwitch!
    @IBOutlet private weak var labelToShowTwitterId: UILabel!
    @IBOutlet private weak var labelForMessageToTweetLaboin: UILabel!
    @IBOutlet private weak var labelForMessageToTweetLaborida: UILabel!
    @IBOutlet private weak var labelForMessageToTweetKaeritai: UILabel!
    @IBOutlet private weak var switchToUseLaboridaChallenge: UISwitch!
    @IBOutlet private weak var labelForNameToTweet: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewTitle
        switchToUseLaboLocate.on = CCDSetting.sharedInstance().useLaboLocate
        switchToUseTwitter.on = CCDSetting.sharedInstance().useTwitter
        switchToUseLaboridaChallenge.on = CCDSetting.sharedInstance().useLaboridaChallenge
        switchToUseLaboLocate.addTarget(self, action: "valueChangedSwitch:", forControlEvents: .ValueChanged)
        switchToUseTwitter.addTarget(self, action: "valueChangedSwitch:", forControlEvents: .ValueChanged)
        switchToUseLaboridaChallenge.addTarget(self, action: "valueChangedSwitch:", forControlEvents: .ValueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let twitterModel = CCDTwitterModel()
        labelToShowTwitterId.text = twitterModel.userName ?? "未ログイン"
        labelForMessageToTweetLaboin.text = CCDSetting.sharedInstance().messageToTweetLaboin
        labelForMessageToTweetLaborida.text = CCDSetting.sharedInstance().messageToTweetLaborida
        labelForMessageToTweetKaeritai.text = CCDSetting.sharedInstance().messageToTweetKaeritai
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if CCDSetting.sharedInstance().useTwitter {
            return 3
        } else {
            return 2
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
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.selectionStyle = .None
        switch (indexPath.section, indexPath.row) {
        case (1, 1):
            let twitterModel = CCDTwitterModel()
            if twitterModel.userName != nil {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        default:
            break
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 2):
            break
        case (0, 3):
            break
        case (0, 4):
            break
        case (1, 1):
            let twitterModel = CCDTwitterModel()
            twitterModel.login()
            break
        case (2, 1):
            break
        default:
            break
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
}
