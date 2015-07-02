//
//  CCDSettingKaeritaiTableViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/30/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class CCDSettingKaeritaiTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet private weak var textViewToShowKaeritaiMessage: UITextView!
    private let minNumberOfChars = 1
    private let maxNumberOfChars = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        textViewToShowKaeritaiMessage.text = CCDSetting.sharedInstance().messageToTweetKaeritai
        changeTextViewColor(minNumberOfChars <= count(textViewToShowKaeritaiMessage.text)
            && count(textViewToShowKaeritaiMessage.text) <= maxNumberOfChars)
        textViewToShowKaeritaiMessage.delegate = self
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if minNumberOfChars <= count(textViewToShowKaeritaiMessage.text)
        && count(textViewToShowKaeritaiMessage.text) <= maxNumberOfChars {
            CCDSetting.sharedInstance().messageToTweetKaeritai = textViewToShowKaeritaiMessage.text
            println("set")
        }
    }

    private func changeTextViewColor(valid: Bool) {
        if valid {
            textViewToShowKaeritaiMessage.textColor = .ultramarineBlueColor()
        } else {
            textViewToShowKaeritaiMessage.textColor = .cherryPinkColor()
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "「かえりたい!」メッセージ"
    }

    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "最大\(maxNumberOfChars)文字"
    }

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        println("begin")
        return true
    }

    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.endEditing(true)
        println(count(textView.text))
        return true
    }
    func textViewDidChange(textView: UITextView) {
        changeTextViewColor(minNumberOfChars <= count(textViewToShowKaeritaiMessage.text)
            && count(textViewToShowKaeritaiMessage.text) <= maxNumberOfChars)
        println("textViewDidChange")
    }
}
