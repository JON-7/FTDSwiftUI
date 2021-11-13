//
//  ScanImageViewModel.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/28/21.
//

import SwiftUI
import Vision

final class ScanImageViewModel: ObservableObject {
    
    var fullText = ""
    
    func scanImage(vm: HomeViewModel) -> String {
        var text = ""
        
        guard let cgImage = vm.tweetImage?.cgImage else {
            return text
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
        var tweetDate = ""
        var tweetDateFormat: TweetDateFormat = .desktop
        let randomId = UUID()
        var filteredText = ""
        var username = ""
        
        // Finding the date of the tweet
        if let desktopPattern = text.matches(for: TweetDatePattern.desktopDate).first {
            tweetDate = desktopPattern
            tweetDateFormat = .desktop
        }
        
        if let mobilePattern = text.matches(for: TweetDatePattern.mobileDate).first {
            tweetDate = mobilePattern.cleanString
            tweetDateFormat = .mobile
        }
        
        // Finding the Tweet body
        filteredText = text.replacingOccurrences(of: tweetDate, with: "\(randomId)")
        
        // Finding the username
        let tweetArray = filteredText.components(separatedBy: " ")
        let usernames = tweetArray.filter { $0.contains("@")}
        
        if let firstUsername = usernames.first {
            username = String(firstUsername.replacingOccurrences(of: "@", with: ""))
        }
        
        return TweetBody(username: username,
                         tweetText: text,
                         stringDate: tweetDate,
                         date: getTweetDate(stringDate: tweetDate.cleanString,
                                            dateFormat: tweetDateFormat))
    }
    
    func getTweetDate(stringDate: String, dateFormat: TweetDateFormat) -> Date {
        let formatter = DateFormatter()
        switch dateFormat {
        case .desktop:
            formatter.dateFormat = "h:mm a MMM dd, yyyy"
        case .mobile:
            formatter.dateFormat = "h:mm a MM/dd/yy"
        }
        let date = formatter.date(from: stringDate)
        
        return date ?? Date()
    }
}
