//
//  TwitterEndpoint.swift
//  FTDSwitUI
//
//  Created by Jon E on 11/5/21.
//

import Foundation

enum TwitterEndpoint: Endpoint {

    case getTwitterID(username: String)
    case getUserTweets(id: String, startTime: String, endTime: String)
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.twitter.com"
    }
    
    var path: String {
        switch self {
        case .getTwitterID:
            return "/2/users/by"
        case .getUserTweets(let id, _ , _):
            return "/2/users/\(id)/tweets"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getTwitterID(username: let username):
            return [URLQueryItem(name: "usernames", value: username)]
            
        case .getUserTweets(_, let startTime, let endTime):
            return [
                URLQueryItem(name: "max_results", value: "100"),
                URLQueryItem(name: "start_time", value: startTime),
                URLQueryItem(name: "end_time", value: endTime),
                URLQueryItem(name: "tweet.fields", value: "created_at")
            ]
        }
    }
    
    var headers: [String : String] {
        return ["Authorization": bearToken]
    }
    
    var method: String {
        return "GET"
    }
}
