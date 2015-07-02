
import TwitterKit
import UIKit

class CCDTwitterModel {
    var userName: String? {
        get {
            if (Twitter.sharedInstance().session() != nil) {
                return Twitter.sharedInstance().session().userName
            } else {
                return nil
            }
        }
    }
    func login() {
        Twitter.sharedInstance().logInWithCompletion {
            (session, error) -> Void in
            switch (session, error) {
            case (.Some, .None):
                CCDSetting.twitterId = session.userName
            default:
                //TODO
                println()
            }
        }
    }

    private let apiClient = Twitter.sharedInstance().APIClient
    private let POST = "POST"
    private let updateJsonURL = "https://api.twitter.com/1.1/statuses/update.json"
    private func getStatusParameter(message: String) -> [NSObject: AnyObject] {
        return ["status": message]
    }
    func tweet(message: String, activityIndicatorView: UIActivityIndicatorView, completionOnSuccess: (() -> ())?, completionOnFailure: ((String) -> ())?) {
        let request = apiClient.URLRequestWithMethod(POST, URL: updateJsonURL, parameters: getStatusParameter(message), error: nil)
        apiClient.sendTwitterRequest(request){(response, data, error) in
            if activityIndicatorView.isAnimating() {
                activityIndicatorView.stopAnimating()
            }
            switch (response, data, error) {
            case (.Some, .Some, .None):
                if let completionOnSuccess = completionOnSuccess {
                    completionOnSuccess()
                }
            default:
                if let completionOnFailure = completionOnFailure {
                    completionOnFailure(error!.localizedDescription)
                }
                println("\(response) \(data) \(error)")
            }
        }
    }

}

