
class CCDMessage {
    private static let _sharedInstance = CCDMessage()
    class func sharedInstance() -> CCDMessage {
        return _sharedInstance
    }

    let inLabo = "らぼのなかなう"
    let outLabo = "らぼのそとなう"

    let useLaboLocate = "検知する"
    let notUseLaboLocate = "検知しない"

    let twitterUserNamePrefix = "@"
    let notLogIn = "未ログイン"
    let tweetSuccessTitle = "ツイート成功"
    let tweetFailureTitle = "ツイート失敗"
    let doneTweet = "ツイートしました"
    let failedToTweet = "ツイート失敗しました"

    let cancelLaboinTitle = "らぼいんキャンセル"

    let yes = "はい"
    let close = "閉じる"
    let cancel = "キャンセル"
    let error = "エラー"
}
