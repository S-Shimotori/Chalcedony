
import UIKit

class CCDSetting {
    private static let _sharedInstance = CCDSetting()
    class func sharedInstance() -> CCDSetting {
        return _sharedInstance
    }

    func initialize() {
        initialized = true
        lastEntranceDate = nil
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
}