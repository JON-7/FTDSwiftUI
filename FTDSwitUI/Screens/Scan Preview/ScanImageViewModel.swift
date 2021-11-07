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
        guard var datePattern = text.matches(for: pattern).first else {
            return TweetBody(username: "", tweetText: "", stringDate: "", date: Date())
        }
        
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
        
        datePattern = getTweetDateFormated(stringDate: datePattern)
        
        return TweetBody(username: username,
                         tweetText: tweetText,
                         stringDate: datePattern,
                         date: getTweetDate(stringDate: datePattern))
    }
    
    func getTweetDateFormated(stringDate: String) -> String {
        var cleanString = stringDate.replacingOccurrences(of: "•", with: "")
        cleanString = cleanString.condenseWhitespace()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a MMM dd, yyyy"
        let date = dateFormatter.date(from: cleanString) ?? Date()
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    func getTweetDate(stringDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a MMM dd, yyyy"
        let date = formatter.date(from: stringDate)
        
        return date ?? Date()
    }
}
