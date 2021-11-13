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
        let pattern = "[0-9]*[:][0-9]{2}.([AaPP][Mm]).*[aA-zZ]{3}.[0-9]*[,].[0-9]{4}"
        let randomId = UUID()
        var filteredText = ""
        var username = ""
        
        // Finding the Tweet date
        guard let datePattern = text.matches(for: pattern).first else {
            return TweetBody(username: "", tweetText: "", stringDate: "", date: Date())
        }
        
        //Finding the Tweet body
        filteredText = text.replacingOccurrences(of: datePattern, with: "\(randomId)")
        
        // Finding the username
        let tweetArray = filteredText.components(separatedBy: " ")
        let usernames = tweetArray.filter { $0.contains("@")}
        
        if let firstUsername = usernames.first {
            username = String(firstUsername.replacingOccurrences(of: "@", with: ""))
        }
        
        return TweetBody(username: username,
                         tweetText: text,
                         stringDate: datePattern,
                         date: getTweetDate(stringDate: datePattern.cleanString))
    }
    
    func getTweetDate(stringDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a MMM dd, yyyy"
        let date = formatter.date(from: stringDate)
        
        return date ?? Date()
    }
}
