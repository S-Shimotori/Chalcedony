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

        setUIToShowStatus(CCDSetting.isInLabo())
        setLabelToShowTheNumberOfKaeritai(CCDSetting.kaeritaiCount)

        activityIndicatorView.frame = CGRectMake(0, 0, 50, 50)
        activityIndicatorView.center = view.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.activityIndicatorViewStyle = .Gray
        view.addSubview(activityIndicatorView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLabelToShowLocateSetting()
        setLabelToShowTwitterSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setUIToShowStatus(inLabo: Bool) {
        if inLabo {
            labelToShowStatus.text = CCDMessage.Status.InLabo.rawValue
            buttonToLaboinAndCancel.setImage(UIImage(named: "cancel.png"), forState: UIControlState.Normal)
            buttonToLaboinAndCancel.backgroundColor = UIColor.cherryPinkColor()
        } else {
            labelToShowStatus.text = CCDMessage.Status.OutLabo.rawValue
            buttonToLaboinAndCancel.setImage(UIImage(named: "laboin.png"), forState: UIControlState.Normal)
            buttonToLaboinAndCancel.backgroundColor = UIColor.ultramarineBlueColor()
        }
    }

    private func setLabelToShowTwitterSetting() {
        let twitterModel = CCDTwitterModel()
        if let userName = twitterModel.userName {
            labelToShowTwitterSetting.text = "\(CCDMessage.twitterUserNamePrefix)\(userName)"
        } else {
            labelToShowTwitterSetting.text = CCDMessage.notLogIn
        }
    }

    private func setLabelToShowLocateSetting() {
        if CCDSetting.useLaboLocate {
            labelToShowLocateSetting.text = CCDMessage.UseLaboLocate.Yes.rawValue
        } else {
            labelToShowLocateSetting.text = CCDMessage.UseLaboLocate.No.rawValue
        }
    }

    private func setLabelToShowTheNumberOfKaeritai(number: Int) {
        if number >= 0 {
            labelToShowTheNumberOfKaeritai.text = "\(number)"
        }
    }

    func touchUpInsideButtonToLaboinAndCancel(sender: UIButton) {
        println("touchUpInsideButtonToLaboinAndCancel")
        let entryLaboModel = CCDEntryLaboModel()

        if !CCDSetting.isInLabo() {
            //らぼいん処理

            if CCDSetting.useTwitter {
                //TODO: ログインしてるかチェック

                if let messageToTweetLaboin = CCDSetting.messageToTweetLaboin {
                    //らぼいんツイートの設定あり
                    activityIndicatorView.startAnimating()
                    let twitterModel = CCDTwitterModel()
                    let showAlertOnSuccessFunction = makeShowAlertWithCloseButtonFunction(CCDMessage.AlertTitle.TweetSuccess.rawValue, message: CCDMessage.AlertBody.DoneTweet.rawValue)
                    let showAlertOnFailureFunction = makeShowAlertWithImplementionFunction(CCDMessage.AlertTitle.TweetFailure.rawValue,
                        message: "\(CCDMessage.AlertBody.FailedToTweet.rawValue)\nツイートをせず入室の記録のみ行いますか?"){(action) in
                        entryLaboModel.laboin()
                        self.setUIToShowStatus(true)
                    }
                    let completionOnSuccess: () -> () = {
                        entryLaboModel.laboin()
                        self.setUIToShowStatus(true)
                        showAlertOnSuccessFunction(nil)
                        println(CCDSetting.lastEntranceDate)
                    }
                    let completionOnFailure: (String) -> () = {(failureReason) in
                        showAlertOnFailureFunction(failureReason)
                    }
                    twitterModel.tweet(messageToTweetLaboin,
                        activityIndicatorView: activityIndicatorView,
                        completionOnSuccess: completionOnSuccess,
                        completionOnFailure: completionOnFailure)
                } else {
                    //ツイート文設定がnil
                    let alertFunction = makeShowAlertWithImplementionFunction(CCDMessage.AlertTitle.TweetFailure.rawValue,
                        message: "\(CCDMessage.AlertBody.FailedToTweet.rawValue)\nツイートをせず入室の記録のみ行いますか?"){(action) in
                        entryLaboModel.laboin()
                        self.setUIToShowStatus(true)
                    }
                    alertFunction("ツイート文が設定されていません")
                }
            } else {
                //記録のみを行う
                entryLaboModel.laboin()
                self.setUIToShowStatus(true)
            }
        } else {
            //取り消し
            let alertFunction = makeShowAlertWithImplementionFunction(CCDMessage.AlertTitle.CancelLaboIn.rawValue,
                message: "入室記録を取り消しますか?"){(action) in
                    entryLaboModel.cancel()
                    self.setUIToShowStatus(false)
                    println(CCDSetting.lastEntranceDate)
            }
            alertFunction(nil)
        }

        println(CCDSetting.lastEntranceDate)
    }

    func touchUpInsideButtonToLaborida(sender: UIButton) {
        let entryLaboModel = CCDEntryLaboModel()
        if CCDSetting.isInLabo() {
            if CCDSetting.useTwitter {
                if let messageToTweetLaborida = CCDSetting.messageToTweetLaborida {
                    //らぼりだツイートの設定あり
                    activityIndicatorView.startAnimating()
                    let twitterModel = CCDTwitterModel()
                    let showAlertOnSuccessFunction = makeShowAlertWithCloseButtonFunction(CCDMessage.AlertTitle.TweetSuccess.rawValue, message: CCDMessage.AlertBody.DoneTweet.rawValue)
                    let showAlertOnFailureFunction = makeShowAlertWithImplementionFunction(CCDMessage.AlertTitle.TweetFailure.rawValue,
                        message: "\(CCDMessage.AlertBody.FailedToTweet.rawValue)\nツイートをせず退室の記録のみ行いますか?"){(action) in
                        entryLaboModel.laborida()
                        self.setUIToShowStatus(false)
                    }
                    let completionOnSuccess: () -> () = {
                        entryLaboModel.laborida()
                        self.setUIToShowStatus(false)
                        showAlertOnSuccessFunction(nil)
                        println(CCDSetting.lastEntranceDate)
                    }
                    let completionOnFailure: (String) -> () = {(failureReason) in
                        showAlertOnFailureFunction(failureReason)
                    }
                    twitterModel.tweet(messageToTweetLaborida,
                        activityIndicatorView: activityIndicatorView,
                        completionOnSuccess: completionOnSuccess,
                        completionOnFailure: completionOnFailure)
                } else {
                    //ツイート文設定がnil
                    let alertFunction = makeShowAlertWithImplementionFunction(CCDMessage.AlertTitle.TweetFailure.rawValue,
                        message: "\(CCDMessage.AlertBody.FailedToTweet.rawValue)\nツイートをせず退室の記録のみ行いますか?"){(action) in
                        entryLaboModel.laborida()
                        self.setUIToShowStatus(false)
                    }
                    alertFunction("ツイート文が設定されていません")
                }
            } else {
                entryLaboModel.laborida()
                setUIToShowStatus(false)
            }
        } else {

        }
        println("touchUpInsideButtonToLaborida")
    }

    func touchUpInsideButtonToTweetKaeritai(sender: UIButton) {
        println("touchUpInsideButtonToTweetKaeritai")
        //ログインしてるかのチェック
        if let messageToTweetKaeritai = CCDSetting.messageToTweetKaeritai {
            activityIndicatorView.startAnimating()

            let twitterModel = CCDTwitterModel()
            let kaeritaiCountModel = CCDKaeritaiCountModel()
            let showAlertOnSuccessFunction = makeShowAlertWithCloseButtonFunction(CCDMessage.AlertTitle.TweetSuccess.rawValue, message: CCDMessage.AlertBody.DoneTweet.rawValue)
            let showAlertOnFailureFunction = makeShowAlertWithCloseButtonFunction(CCDMessage.AlertTitle.TweetFailure.rawValue, message: CCDMessage.AlertBody.FailedToTweet.rawValue)
            let completionOnSuccess: () -> () = {
                kaeritaiCountModel.incrementCount()
                self.setLabelToShowTheNumberOfKaeritai(CCDSetting.kaeritaiCount)
                showAlertOnSuccessFunction(nil)
            }
            let completionOnFailure: (String) -> () = {(failureReason) in
                showAlertOnFailureFunction(failureReason)
            }
            twitterModel.tweet("\(messageToTweetKaeritai)(\(CCDSetting.kaeritaiCount+1)回目)",
                activityIndicatorView: activityIndicatorView,
                completionOnSuccess: completionOnSuccess,
                completionOnFailure: completionOnFailure)
        } else {
            makeShowAlertWithCloseButtonFunction(CCDMessage.AlertTitle.TweetFailure.rawValue, message: "\(CCDMessage.AlertBody.FailedToTweet.rawValue)\nツイート文が設定されていません")(nil)
        }
    }

    private func makeShowAlertWithCloseButtonFunction(title: String, message: String) -> ((String?)->()) {
        let closeAlertAction = UIAlertAction(title: CCDMessage.AlertButton.Close.rawValue, style: .Default, handler: nil)
        return {(failureReason) in
            let fullMessage: String
            if let failureReason = failureReason {
                fullMessage = "\(message)\n(\(CCDMessage.AlertBody.Error.rawValue): \(failureReason))"
            } else {
                fullMessage = message
            }
            let alert = UIAlertController(title: title, message: fullMessage, preferredStyle: .Alert)
            alert.addAction(closeAlertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    private func makeShowAlertWithImplementionFunction(title: String, message: String, completion: ((UIAlertAction!) -> ())?) -> ((String?)->()) {
        let implementAlertAction = UIAlertAction(title: CCDMessage.AlertButton.Yes.rawValue, style: .Default, handler: completion)
        let cancelAlertAction = UIAlertAction(title: CCDMessage.AlertButton.Cancel.rawValue, style: .Cancel, handler: nil)
        return {(failureReason) in
            let bodyMessage: String
            if let failureReason = failureReason {
                bodyMessage = "\(message)\n(\(CCDMessage.AlertBody.Error.rawValue): \(failureReason))"
            } else {
                bodyMessage = message
            }
            let alert = UIAlertController(title: title, message: bodyMessage, preferredStyle: .Alert)
            alert.addAction(implementAlertAction)
            alert.addAction(cancelAlertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

}
