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
    
    func getTweetDateFormated(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a MMM dd, yyyy"
        let date = dateFormatter.date(from: stringDate) ?? Date()
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    func getTwitterID(username: String, completion: @escaping (String) -> ()) {
        NetworkLayer.request(endpoint: TwitterEndpoint.getTwitterID(username: username)) { (result: Result<TwitterID, Error>) in
            switch result {
            case .success(let ID):
                completion(ID.data.first?.id ?? "0")
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
    func getUserTweets(id: String, startTime: String, endTime: String, completion: @escaping(UserTweets) ->()) {
        NetworkLayer.request(endpoint: TwitterEndpoint.getUserTweets(id: id, startTime: startTime, endTime: endTime)) { (result: Result<UserTweets, Error>) in
            switch result {
            case .success(let tweets):
                completion(tweets)
            case .failure(_):
                completion(UserTweets(data: [TweetData(createdAt: "", text: "")]))
            }
        }
    }
    
    func findTweet(imageText: String, userTweets: [TweetData], completion: @escaping (Bool) ->()){
        var textFound = false
        for n in 0..<userTweets.count {

            if userTweets[n].text == imageText {
                textFound = true
            }
        }
        completion(textFound)
    }
}
