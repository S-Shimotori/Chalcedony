
class CCDSettingTableList {
    private static let _sharedInstance = CCDSettingTableList()
    class func sharedInstance() -> CCDSettingTableList {
        return _sharedInstance
    }
    let settingTitleList = [
        "らぼ位置検知",
        "Twitter連携",
        "らぼりだチャレンジ"
    ]
    let settingList = [
        [
            "検知する",
            "らぼの位置を設定..."
        ],
        [
            "ツイートを行う",
            "アカウント",
            "「らぼいん!」メッセージ",
            "「らぼりだ!」メッセージ",
            "「かえりたい!」メッセージ"
        ],
        [
            "チャレンジする",
            "使用する名前"
        ]
    ]

    let settingListCellType:[[Type]] = [
        [.Switch, .Detail],
        [.Switch, .Detail, .Detail, .Detail, .Detail],
        [.Switch, .Detail]
    ]
    enum Type {
        case Switch
        case Detail
    }
}