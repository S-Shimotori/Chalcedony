
import TwitterKit
import UIKit

class CCDTwitterModel {
    var userName: String? {
        get {
            if TWTRUser().isVerified == true {
                return TWTRUser().userID
            } else {
                return nil
            }
        }
    }
    let apiClient = Twitter.sharedInstance().APIClient
    func login() {
        Twitter.sharedInstance().logInWithCompletion {
            (session, error) -> Void in
            switch (session, error) {
            case (.Some, .None):
                CCDSetting.sharedInstance().twitterId = session.userName
            default:
                //TODO
                println()
            }
        }
    }
}

