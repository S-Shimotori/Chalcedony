
import UIKit

struct CCDSetting {
    private enum BoolForKey: String {
        case Initialized = "initialized"
        case UseTwitter = "useTwitter"
        case UseLaboridaChallenge = "useLaboridaChallenge"
        case UseLaboLocate = "useLaboLocate"
    }
    private enum NSDateForKey: String {
        case LastEntranceDate = "lastEntranceDate"
    }
    private enum IntForKey: String {
        case KaeritaiCount = "kaeritaiCount"
    }
    private enum StringForKey: String {
        case TwitterId = "twitterId"
        case MessageToTweetLaboin = "messageToTweetLaboin"
        case MessageToTweetLaborida = "messageToTweetLaborida"
        case MessageToTweetKaeritai = "messageToTweetKaeritai"
    }
    static func initializeApplication() {
        initialized = true
        lastEntranceDate = nil
        kaeritaiCount = 0
        twitterId = nil
        messageToTweetLaboin = "らぼなう"
        messageToTweetLaborida = "らぼりだ"
        messageToTweetKaeritai = "研゛究゛室゛や゛だ゛ーーーーー！！！お゛う゛ち゛か゛え゛る゛ーーーーーーーーーー！！！！！！"
    }
    static var initialized: Bool {
        get {
            return getBool(.Initialized)
        }
        set(newValue) {
            setBool(newValue, boolForKey: .Initialized)
        }
    }

    static var lastEntranceDate: NSDate? {
        get {
            return getNSDate(.LastEntranceDate)
        }
        set(newValue) {
            setNSDate(newValue, nsDateForKey: .LastEntranceDate)
        }
    }
    static func isInLabo() -> Bool {
        if let lastEntranceDate = lastEntranceDate {
            return true
        } else {
            return false
        }
    }

    static var kaeritaiCount: Int {
        get {
            return getInt(.KaeritaiCount)
        }
        set(newValue) {
            setInt(newValue, intForKey: .KaeritaiCount)
        }
    }

    static var twitterId: String? {
        get {
            return getString(.TwitterId)
        }
        set(newValue) {
            setString(newValue, stringForKey: .TwitterId)
        }
    }

    static var useTwitter: Bool {
        get {
            return getBool(.UseTwitter)
        }
        set(newValue) {
            setBool(newValue, boolForKey: .UseTwitter)
        }
    }

    static var useLaboridaChallenge: Bool {
        get {
            return getBool(.UseLaboridaChallenge)
        }
        set(newValue) {
            setBool(newValue, boolForKey: .UseLaboridaChallenge)
        }
    }

    static var useLaboLocate: Bool {
        get {
            return getBool(.UseLaboLocate)
        }
        set(newValue) {
            setBool(newValue, boolForKey: .UseLaboLocate)
        }
    }

    static var messageToTweetLaboin: String? {
        get {
            return getString(.MessageToTweetLaboin)
        }
        set(newValue) {
            setString(newValue, stringForKey: .MessageToTweetLaboin)
        }
    }

    static var messageToTweetLaborida: String? {
        get {
            return getString(.MessageToTweetLaborida)
        }
        set(newValue) {
            setString(newValue, stringForKey: .MessageToTweetLaborida)
        }
    }

    static var messageToTweetKaeritai: String? {
        get {
            return getString(.MessageToTweetKaeritai)
        }
        set(newValue) {
            setString(newValue, stringForKey: .MessageToTweetKaeritai)
        }
    }

    private static func setBool(value: Bool, boolForKey: BoolForKey) {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: boolForKey.rawValue)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    private static func getBool(boolForKey: BoolForKey) -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(boolForKey.rawValue)
    }
    private static func setInt(value: Int, intForKey: IntForKey) {
        NSUserDefaults.standardUserDefaults().setInteger(value, forKey: intForKey.rawValue)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    private static func getInt(intForKey: IntForKey) -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey(intForKey.rawValue)
    }

    private static func setNSDate(value: NSDate?, nsDateForKey: NSDateForKey) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: nsDateForKey.rawValue)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    private static func getNSDate(nsDateForKey: NSDateForKey) -> NSDate? {
        return NSUserDefaults.standardUserDefaults().objectForKey(nsDateForKey.rawValue) as? NSDate
    }

    private static func setString(value: String?, stringForKey: StringForKey) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: stringForKey.rawValue)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    private static func getString(stringForKey: StringForKey) -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey(stringForKey.rawValue) as? String
    }
}
