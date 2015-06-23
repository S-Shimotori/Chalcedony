
class CCDEntryModel {
    func laboin() {
        CCDSetting.sharedInstance().lastEntranceDate = NSDate()
    }

    func cancel() {
        CCDSetting.sharedInstance().lastEntranceDate = nil
    }
    func laborida() {
        CCDSetting.sharedInstance().lastEntranceDate = nil
    }
}