//
//  ScanImageViewModel.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/28/21.
//

import SwiftUI
import Vision

final class ScanImageViewModel: ObservableObject {
    
    @Published var fullText = ""
    
    func scanImage(vm: HomeViewModel) -> String {
        var text = ""
        
        guard let cgImage = vm.tweetImage?.cgImage else {
            return ""
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { request, error in
            guard let observation = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                      return
                  }
            text = observation.compactMap ({
                $0.topCandidates(1).first?.string
            }).joined(separator: " ")
        }
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
        return text
    }
    
    func getTweetInfo(text: String) -> TweetBody {
        let pattern = "[0-9]*[:][0-9]{2}.([AaPP][Mm]).*[aA-zZ]{3}.[0-9]*[,].[0-9]{4}"
        let randomId = UUID()
        var filteredText = ""
        var tweetText = ""
        var username = ""
        
        // Finding the Tweet date
        guard var datePattern = text.matches(for: pattern).first
        else {
            return TweetBody(username: "", tweetText: "", date: "")
        }
        datePattern = getTweetDateFormated(stringDate: datePattern)
        
        //Finding the Tweet body
        filteredText = text.replacingOccurrences(of: datePattern, with: "\(randomId)")
        let tweetArray = filteredText.components(separatedBy: " ")
        if let dateIndex = tweetArray.firstIndex(of: "\(randomId)") {
            tweetText = tweetArray.prefix(dateIndex).joined(separator: " ")
        }
        
        // Finding the username
        let usernames = tweetArray.filter { $0.contains("@")}
        
        if let firstUsername = usernames.first {
            username = String(firstUsername.replacingOccurrences(of: "@", with: ""))
        }
        
        return TweetBody(username: username,
                         tweetText: tweetText,
                         date: datePattern)
    }
    
    func getTwitterID(username: String) -> String {
        var twitterID = ""
        NetworkLayer.request(endpoint: TwitterEndpoint.getTwitterID(username: username)) { (result: Result<TwitterID, Error>) in
            switch result {
            case .success(let ID):
                twitterID = ID.data.first?.id ?? "0"
            case .failure(let error):
                twitterID = error.localizedDescription
            }
        }
        return twitterID
    }
    
//    func getUserTweets(id: String) -> UserTweets {
//
//    }

}

func getTweetDateFormated(stringDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a MMM dd, yyyy"
    let date = dateFormatter.date(from: stringDate) ?? Date()
    let stringDate = dateFormatter.string(from: date)
    
    return stringDate
}
