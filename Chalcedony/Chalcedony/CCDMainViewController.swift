//
//  MainViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/19/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class CCDMainViewController: UIViewController {
    @IBOutlet private weak var labelToShowStatus: UILabel!
    @IBOutlet private weak var labelToShowHowLongStay: UILabel!
    @IBOutlet private weak var labelToShowTwitterSetting: UILabel!
    @IBOutlet private weak var labelToShowLocateSetting: UILabel!

    @IBOutlet private weak var labelToShowTheNumberOfKaeritai: UILabel!


    @IBOutlet private weak var buttonToLaboinAndCancel: UIButton!
    @IBOutlet private weak var buttonToLaborida: UIButton!
    @IBOutlet private weak var buttonToTweetKaeritai: UIButton!

    private let activityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonToLaboinAndCancel.addTarget(self, action: "touchUpInsideButtonToLaboinAndCancel:", forControlEvents: .TouchUpInside)
        buttonToLaborida.addTarget(self, action: "touchUpInsideButtonToLaborida:", forControlEvents: .TouchUpInside)
        buttonToTweetKaeritai.addTarget(self, action: "touchUpInsideButtonToTweetKaeritai:", forControlEvents: .TouchUpInside)

        setLabelToShowStatus(CCDSetting.sharedInstance().isInLabo())
        setLabelToShowTheNumberOfKaeritai(CCDSetting.sharedInstance().kaeritaiCount)

        activityIndicatorView.frame = CGRectMake(0, 0, 50, 50)
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.activityIndicatorViewStyle = .Gray
        view.addSubview(activityIndicatorView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setLabelToShowStatus(inLabo: Bool) {
        if inLabo {
            labelToShowStatus.text = CCDMessage.sharedInstance().inLabo
        } else {
            labelToShowStatus.text = CCDMessage.sharedInstance().outLabo
        }
    }

    private func setLabelToShowTheNumberOfKaeritai(number: Int) {
        if number >= 0 {
            labelToShowTheNumberOfKaeritai.text = "\(number)"
        }
    }

    func touchUpInsideButtonToLaboinAndCancel(sender: UIButton) {
        println("touchUpInsideButtonToLaboinAndCancel")
        let entryModel = CCDEntryModel()
        if !CCDSetting.sharedInstance().isInLabo() {
            entryModel.laboin()
            setLabelToShowStatus(true)
        } else {
            // TODO
        }
    }

    func touchUpInsideButtonToLaborida(sender: UIButton) {
        let entryModel = CCDEntryModel()
        if CCDSetting.sharedInstance().isInLabo() {
            entryModel.laborida()
            setLabelToShowStatus(false)
        }
        println("touchUpInsideButtonToLaborida")
    }

    func touchUpInsideButtonToTweetKaeritai(sender: UIButton) {
        println("touchUpInsideButtonToTweetKaeritai")
        //ログインしてるかのチェック
        if let messageToTweetKaeritai = CCDSetting.sharedInstance().messageToTweetKaeritai {
            activityIndicatorView.startAnimating()

            let twitterModel = CCDTwitterModel()
            let kaeritaiCountModel = CCDKaeritaiCountModel()
            let showAlertOnSuccessFunction = makeShowAlertWithCloseButtonFunction("ツイート成功", message: "ツイートしました")
            let showAlertOnFailureFunction = makeShowAlertWithCloseButtonFunction("ツイート失敗", message: "ツイート失敗しました")
            let completionOnSuccess: () -> () = {
                kaeritaiCountModel.incrementCount()
                self.setLabelToShowTheNumberOfKaeritai(CCDSetting.sharedInstance().kaeritaiCount)
                showAlertOnSuccessFunction(nil)
            }
            let completionOnFailure: (String) -> () = {(failureReason) in
                showAlertOnFailureFunction(failureReason)
            }
            twitterModel.tweet("\(messageToTweetKaeritai)(\(CCDSetting.sharedInstance().kaeritaiCount+1)回目)",
                activityIndicatorView: activityIndicatorView,
                completionOnSuccess: completionOnSuccess,
                completionOnFailure: completionOnFailure)
        } else {
            makeShowAlertWithCloseButtonFunction("ツイート失敗", message: "ツイート文が設定されていません")(nil)
        }
    }

    private func makeShowAlertWithCloseButtonFunction(title: String, message: String) -> ((String?)->()) {
        let closeAlertAction = UIAlertAction(title: "閉じる", style: .Default, handler: nil)
        return {(failureReason) in
            let fullMessage: String
            if let failureReason = failureReason {
                fullMessage = "\(message)\n(エラー: \(failureReason))"
            } else {
                fullMessage = message
            }
            let alert = UIAlertController(title: title, message: fullMessage, preferredStyle: .Alert)
            alert.addAction(closeAlertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    private func makeShowAlertWithImplementionFunction(title: String, message: String, completion: ((UIAlertAction!) -> ())?) -> ((String)->()) {
        let implementAlertAction = UIAlertAction(title: "はい", style: .Default, handler: completion)
        let cancelAlertAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
        return {(failureReason) in
            let alert = UIAlertController(title: title, message: "\(message)\n(エラー: \(failureReason))", preferredStyle: .Alert)
            alert.addAction(implementAlertAction)
            alert.addAction(cancelAlertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

}
