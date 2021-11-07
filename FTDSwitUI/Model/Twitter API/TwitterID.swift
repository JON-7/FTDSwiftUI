//
//  TwitterID.swift
//  FTDSwitUI
//
//  Created by Jon E on 11/5/21.
//

import Foundation

struct TwitterIDData: Codable {
    var id: String
    var username: String
}

struct TwitterID: Codable {
    var data: [TwitterIDData]
}
