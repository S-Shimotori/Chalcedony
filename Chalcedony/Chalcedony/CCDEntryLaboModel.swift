
class CCDEntryLaboModel {
    func laboin() {
        CCDSetting.lastEntranceDate = NSDate()
    }

    func cancel() {
        CCDSetting.lastEntranceDate = nil
    }
    func laborida() {
        CCDSetting.lastEntranceDate = nil
    }
}