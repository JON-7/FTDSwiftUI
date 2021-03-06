//
//  String+Extension.swift
//  FTDSwitUI
//
//  Created by Jon E on 11/5/21.
//

import SwiftUI

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
    
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    var cleanString: String {
        var originalString = self
        originalString = originalString.replacingOccurrences(of: ",", with: " ")
        originalString = originalString.replacingOccurrences(of: "•", with: "")
        originalString = originalString.replacingOccurrences(of: "-", with: " ")
        return originalString
    }
}
