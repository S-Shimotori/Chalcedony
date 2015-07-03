
import RealmSwift

class CCDEntryLaboModel {
    func laboin(laboinDate: NSDate) {
        CCDSetting.lastEntranceDate = laboinDate
    }

    func cancel() {
        CCDSetting.lastEntranceDate = nil
    }
    func laborida(laboridaDate: NSDate) {
        if let lastEntranceDate = CCDSetting.lastEntranceDate {
            let realm = Realm()
            let data = CCDDataRealmModel()
            data.laboinDate = lastEntranceDate
            data.laboridaDate = laboridaDate
            realm.write{
                realm.add(data)
            }
        } else {
            println("no last entrance data")
        }
        CCDSetting.lastEntranceDate = nil
    }
}
