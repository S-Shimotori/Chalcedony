
import UIKit

class CCDSetting {
    private static let _sharedInstance = CCDSetting()
    class func sharedInstance() -> CCDSetting {
        return _sharedInstance
    }

    func initialize() {
        initialized = true
        lastEntranceDate = nil
        kaeritaiCount = 0
        twitterId = nil
    }

    var initialized: Bool {
        get {
        return NSUserDefaults.standardUserDefaults().boolForKey("initialized")
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "initialized")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    var lastEntranceDate: NSDate? {
        get {
        return NSUserDefaults.standardUserDefaults().objectForKey("lastEntranceDate") as? NSDate
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "lastEntranceDate")
        }
    }

    func isInLabo() -> Bool {
        if let lastEntrance = lastEntranceDate {
            return true
        } else {
            return false
        }
    }

    var kaeritaiCount: Int {
        get {
        return NSUserDefaults.standardUserDefaults().objectForKey("kaeritaiCount") as! Int
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "kaeritaiCount")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    var twitterId: String? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey("twitterId")
        }
        set(newValue) {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "twitterId")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}