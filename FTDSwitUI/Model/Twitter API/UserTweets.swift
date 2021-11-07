//
//  UserTweets.swift
//  FTDSwitUI
//
//  Created by Jon E on 11/5/21.
//

import Foundation

struct TweetData: Codable {
    var createdAt: String
    var text: String
}

struct UserTweets: Codable {
    let data: [TweetData]
}
