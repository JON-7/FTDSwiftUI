//
//  FTDAlert.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/31/21.
//

import Foundation

enum FTDAlert: Error {
    // Network errors
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
    
    // Image errors
    case invalidImage
    case dateNotFound
    case handleNotFound
    
    // Twitter user errors
    case invalidUser
    case tweetsNotFound
}
