
class CCDSettingTableList {
    private static let _sharedInstance = CCDSettingTableList()
    class func sharedInstance() -> CCDSettingTableList {
        return _sharedInstance
    }
    let settingTitleList = [
        "Twitter連携",
        "らぼりだチャレンジ",
        "らぼ位置検知"
    ]
    let settingList = [
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
        ],
        [
            "検知する",
            "らぼの位置を設定..."
        ]
    ]

    let settingListCellType:[[Type]] = [
        [.Switch, .Detail, .Detail, .Detail, .Detail],
        [.Switch, .Detail],
        [.Switch, .Detail]
    ]
    enum Type {
        case Switch
        case Detail
    }
}