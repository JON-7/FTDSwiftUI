//
//  ResultViewModel.swift
//  FTDSwitUI
//
//  Created by Jon E on 11/6/21.
//

import SwiftUI

final class ResultViewModel: ObservableObject {
    
    @Published var isTweetReal = false
    @Published var isSheetSelected = false
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
    func getTwitterID(username: String, completion: @escaping (String) -> ()) {
        NetworkLayer.request(endpoint: TwitterEndpoint.getTwitterID(username: username)) { (result: Result<TwitterID, FTDAlert>) in
            switch result {
            case .success(let ID):
                completion(ID.data.first?.id ?? "0")
            case .failure(_):
                completion("Username not found")
            }
        }
    }
    
    func getUserTweets(id: String, startTime: String, endTime: String, completion: @escaping(UserTweets) ->()) {
        NetworkLayer.request(endpoint: TwitterEndpoint.getUserTweets(id: id, startTime: startTime, endTime: endTime)) { [self] (result: Result<UserTweets, FTDAlert>) in
            switch result {
            case .success(let tweets):
                completion(tweets)
            case .failure(let error):
                setError(error: error)
            }
        }
    }
    
    // searches users tweets from 24 hrs before and after the tweet was posted
    func findTweet(imageText: String, userTweets: [TweetData], completion: @escaping (String) ->()){
        var tweetFound = ""
        
        for n in 0..<userTweets.count {
            let currentTweetText = userTweets[n].text
            
            if verifyTweet(imageText: imageText, tweetText: currentTweetText) {
                tweetFound = currentTweetText
            }
        }
        completion(tweetFound)
    }
    
    // checks if the tweet found matches the text scanned from the image
    func verifyTweet(imageText: String, tweetText: String) -> Bool {
        let imageTextArray = imageText.cleanString.components(separatedBy: " ")
        let tweetTextArray = tweetText.cleanString.components(separatedBy: " ")
        var missingCount = 0
        
        for n in 0..<tweetTextArray.count {
            if !imageTextArray.contains(tweetTextArray[n]) {
                missingCount += 1
            }
        }
        
        return (missingCount == 0 ? true : false)
    }
    
    func setError(error: FTDAlert) {
        DispatchQueue.main.async { [self] in
            switch error {
            case .invalidURL:
                alertItem = AlertContext.invalidURL
            case .invalidResponse:
                alertItem = AlertContext.invalidResponse
            case .invalidData:
                alertItem = AlertContext.invalidData
            case .unableToComplete:
                alertItem = AlertContext.unableToComplete
            case .invalidImage:
                alertItem = AlertContext.invalidPicture
            case .dateNotFound:
                alertItem = AlertContext.dateNotFound
            case .handleNotFound:
                alertItem = AlertContext.handleNotFound
            case .invalidUser:
                alertItem = AlertContext.invalidUser
            case .tweetsNotFound:
                alertItem = AlertContext.tweetsNotFound
            }
        }
    }
}
