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

        setUIToShowStatus(CCDSetting.sharedInstance().isInLabo())
        setLabelToShowTheNumberOfKaeritai(CCDSetting.sharedInstance().kaeritaiCount)

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
            labelToShowStatus.text = CCDMessage.sharedInstance().inLabo
            buttonToLaboinAndCancel.setImage(UIImage(named: "cancel.png"), forState: UIControlState.Normal)
            buttonToLaboinAndCancel.backgroundColor = UIColor.cherryPinkColor()
        } else {
            labelToShowStatus.text = CCDMessage.sharedInstance().outLabo
            buttonToLaboinAndCancel.setImage(UIImage(named: "laboin.png"), forState: UIControlState.Normal)
            buttonToLaboinAndCancel.backgroundColor = UIColor.ultramarineBlueColor()
        }
    }

    private func setLabelToShowTwitterSetting() {
        let twitterModel = CCDTwitterModel()
        if let userName = twitterModel.userName {
            labelToShowTwitterSetting.text = "@\(userName)"
        } else {
            labelToShowTwitterSetting.text = "未ログイン"
        }
    }

    private func setLabelToShowLocateSetting() {
        if CCDSetting.sharedInstance().useLaboLocate {
            labelToShowLocateSetting.text = "検知する"
        } else {
            labelToShowLocateSetting.text = "検知しない"
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

        if !CCDSetting.sharedInstance().isInLabo() {
            //らぼいん処理

            if CCDSetting.sharedInstance().useTwitter {
                //TODO: ログインしてるかチェック

                if let messageToTweetLaboin = CCDSetting.sharedInstance().messageToTweetLaboin {
                    //らぼいんツイートの設定あり
                    activityIndicatorView.startAnimating()
                    let twitterModel = CCDTwitterModel()
                    let showAlertOnSuccessFunction = makeShowAlertWithCloseButtonFunction("ツイート成功", message: "ツイートしました")
                    let showAlertOnFailureFunction = makeShowAlertWithImplementionFunction("ツイート失敗",
                        message: "ツイート失敗しました\nツイートをせず入室の記録のみ行いますか?"){(action) in
                        entryLaboModel.laboin()
                        self.setUIToShowStatus(true)
                    }
                    let completionOnSuccess: () -> () = {
                        entryLaboModel.laboin()
                        self.setUIToShowStatus(true)
                        showAlertOnSuccessFunction(nil)
                        println(CCDSetting.sharedInstance().lastEntranceDate)
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
                    let alertFunction = makeShowAlertWithImplementionFunction("ツイート失敗",
                        message: "ツイートをせず入室の記録のみ行いますか?"){(action) in
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
            let alertFunction = makeShowAlertWithImplementionFunction("らぼいん取り消し",
                message: "入室記録を取り消しますか?"){(action) in
                    entryLaboModel.cancel()
                    self.setUIToShowStatus(false)
                    println(CCDSetting.sharedInstance().lastEntranceDate)
            }
            alertFunction(nil)
        }

        println(CCDSetting.sharedInstance().lastEntranceDate)
    }

    func touchUpInsideButtonToLaborida(sender: UIButton) {
        let entryLaboModel = CCDEntryLaboModel()
        if CCDSetting.sharedInstance().isInLabo() {
            if CCDSetting.sharedInstance().useTwitter {
                if let messageToTweetLaborida = CCDSetting.sharedInstance().messageToTweetLaborida {
                    //らぼりだツイートの設定あり
                    activityIndicatorView.startAnimating()
                    let twitterModel = CCDTwitterModel()
                    let showAlertOnSuccessFunction = makeShowAlertWithCloseButtonFunction("ツイート成功", message: "ツイートしました")
                    let showAlertOnFailureFunction = makeShowAlertWithImplementionFunction("ツイート失敗",
                        message: "ツイート失敗しました\nツイートをせず退室の記録のみ行いますか?"){(action) in
                        entryLaboModel.laborida()
                        self.setUIToShowStatus(false)
                    }
                    let completionOnSuccess: () -> () = {
                        entryLaboModel.laborida()
                        self.setUIToShowStatus(false)
                        showAlertOnSuccessFunction(nil)
                        println(CCDSetting.sharedInstance().lastEntranceDate)
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
                    let alertFunction = makeShowAlertWithImplementionFunction("ツイート失敗",
                        message: "ツイートをせず退室の記録のみ行いますか?"){(action) in
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

    private func makeShowAlertWithImplementionFunction(title: String, message: String, completion: ((UIAlertAction!) -> ())?) -> ((String?)->()) {
        let implementAlertAction = UIAlertAction(title: "はい", style: .Default, handler: completion)
        let cancelAlertAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
        return {(failureReason) in
            let bodyMessage: String
            if let failureReason = failureReason {
                bodyMessage = "\(message)\n(エラー: \(failureReason))"
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
