
class CCDMessage {
    private static let _sharedInstance = CCDMessage()
    class func sharedInstance() -> CCDMessage {
        return _sharedInstance
    }

    let inLabo = "らぼのなかなう"
    let outLabo = "らぼのそとなう"
}