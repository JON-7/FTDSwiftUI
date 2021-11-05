//
//  ScanImageViewModel.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/28/21.
//

import SwiftUI
import Vision

final class ScanImageViewModel: ObservableObject {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    func scanImage() -> String {
        
        var text = ""
        
        if viewModel.tweetImage == nil {
            
        }
        
        guard let cgImage = viewModel.tweetImage?.cgImage else {
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
        
        // Finding the Tweet date
        guard let datePattern = text.matches(for: pattern).first
        else {
            return TweetBody(username: "", tweetText: "", date: "")
        }
        
        //Finding the Tweet body
        filteredText = text.replacingOccurrences(of: datePattern, with: "\(randomId)")
        let tweetArray = filteredText.components(separatedBy: " ")
        if let dateIndex = tweetArray.firstIndex(of: "\(randomId)") {
            tweetText = tweetArray.prefix(dateIndex).joined(separator: " ")
        }
        
        // Finding the username
        let usernames = tweetArray.filter { $0.contains("@")}
        
        return TweetBody(username: usernames.first ?? "",
                         tweetText: tweetText,
                         date: datePattern)
    }
}

struct Tweet {
    let handle: String
    let body: String
    let date: String
    
    init(handle: String, body: String, date: String) {
        self.handle = handle
        self.body = body
        self.date = date
    }
}


struct TweetBody {
    var username: String
    var tweetText: String
    var date: String
}

enum TweetDateRegex {
    static let hrMinRegex = "[0-9]*:[0-9]{2}"
    static let dayRegex = "[0-9]*,"
    static let monthRegex = "[aA-zZ]{3}"
    static let yearRegex = "[0-9]{4}"
}

extension String {
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
