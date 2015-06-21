//
//  CCDAboutAppViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/19/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class CCDAboutAppViewController: UIViewController {
    private let pageTitle = "アプリについて"
    @IBOutlet private weak var textViewAboutApp: UITextView!
    private let aboutAppText = "AboutApp"
    private let aboutAppExtension = "txt"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pageTitle
        let filePath = NSBundle.mainBundle().pathForResource(aboutAppText, ofType: aboutAppExtension)

        if let filePath = filePath {
            let stringFromFile = NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)
            if let stringFromFile = stringFromFile as? String {
                textViewAboutApp.text = stringFromFile
            }
        }
    }
}
