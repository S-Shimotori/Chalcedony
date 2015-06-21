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

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonToLaboinAndCancel.addTarget(self, action: "touchUpInsideButtonToLaboinAndCancel:", forControlEvents: .TouchUpInside)
        buttonToLaborida.addTarget(self, action: "touchUpInsideButtonToLaborida:", forControlEvents: .TouchUpInside)
        buttonToTweetKaeritai.addTarget(self, action: "touchUpInsideButtonToTweetKaeritai:", forControlEvents: .TouchUpInside)

        setLabelToShowStatus(CCDSetting.sharedInstance().isInLabo())
        setLabelToShowTheNumberOfKaeritai(CCDSetting.sharedInstance().kaeritaiCount)
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
        let kaeritaiCountModel = CCDKaeritaiCountModel()
        kaeritaiCountModel.incrementCount()
        setLabelToShowTheNumberOfKaeritai(CCDSetting.sharedInstance().kaeritaiCount)
    }
}
