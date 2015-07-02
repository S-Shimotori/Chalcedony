//
//  CCDMessage.swift
//  Chalcedony
//
//  Created by S-Shimotori on 7/2/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

struct CCDMessage {
    enum Status: String {
        case InLabo = "らぼのなかなう"
        case OutLabo = "らぼのそとなう"
    }

    enum UseLaboLocate: String {
        case Yes = "検知する"
        case No = "検知しない"
    }

    static let twitterUserNamePrefix = "@"
    static let notLogIn = "未ログイン"

    enum AlertTitle: String {
        case TweetSuccess = "ツイート成功"
        case TweetFailure = "ツイート失敗"
        case CancelLaboIn = "らぼいんキャンセル"
    }
    enum AlertBody: String {
        case DoneTweet = "ツイートしました"
        case FailedToTweet = "ツイート失敗しました"
        case Error = "エラー"
    }
    enum AlertButton: String {
        case Yes = "はい"
        case Close = "閉じる"
        case Cancel = "キャンセル"
    }
}