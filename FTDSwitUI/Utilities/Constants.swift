//
//  Constants.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

struct AppImages {
    static let appLogo = Image("appLogo")
    static let infoCircle = "info.circle"
    static let xmark = Image(systemName: "xmark")
    static let realTweet = "realTweetImage"
    static let fakeTweet = "fakeTweetImage"
}

struct TweetDatePattern {
    // pattern: 12:00 AM • Jan 01,2021
    static let desktopDate = "[0-9]*[:][0-9]{2}.([AaPP][Mm]).*[aA-zZ]{3}.[0-9]*[,].[0-9]{4}"
    // pattern: 12:00 AM • 01/01/21
    static let mobileDate = "[0-9]*[:][0-9]{2}.([AaPP][Mm]).*[0-9]*/[0-9]*/[0-9]{2}"
}

enum TweetDateFormat {
    case desktop
    case mobile
}
