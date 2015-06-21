
import TwitterKit
import UIKit

class CCDTwitterModel {
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

