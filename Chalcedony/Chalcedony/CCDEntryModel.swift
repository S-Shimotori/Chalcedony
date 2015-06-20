
class CCDEntryModel {
    func laboin() {
        CCDSetting.sharedInstance().lastEntranceDate = NSDate()
    }

    func laborida() {
        CCDSetting.sharedInstance().lastEntranceDate = nil
    }
}