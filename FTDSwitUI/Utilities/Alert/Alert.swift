//
//  Alert.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/31/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //MARK: Network Errors
    static let invalidURL = AlertItem(title: Text("Error"),
                                      message: Text("The data received from the server was invalid"),
                                      dismissButton: .default(Text("OK")))
    
    static let invalidResponse = AlertItem(title: Text("Error"),
                                           message: Text("Invalid response from the server"),
                                           dismissButton: .default(Text("OK")))
    
    static let invalidData = AlertItem(title: Text("Error"),
                                      message: Text("There was an issue connecting to the server"),
                                       dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Error"),
                                            message: Text("Please check your internet connection"),
                                            dismissButton: .default(Text("OK")))
    
    
    //MARK: Image Errors
    static let invalidPicture = AlertItem(title: Text("Invalid Image"),
                                          message: Text("Please choose/retake another picture."),
                                          dismissButton: .default(Text("OK")))
    
    static let dateNotFound = AlertItem(title: Text("Could Not Find A Date"),
                                          message: Text("Please choose/retake another picture."),
                                          dismissButton: .default(Text("OK")))
    
    static let handleNotFound = AlertItem(title: Text("Could Not Find Handle"),
                                          message: Text("Please choose choose/retake picture."),
                                          dismissButton: .default(Text("OK")))
    
    //MARK: Twitter User Errors
    static let invalidUser = AlertItem(title: Text("Error"),
                                      message: Text("Could not find user"),
                                      dismissButton: .default(Text("OK")))
    
    static let tweetsNotFound = AlertItem(title: Text("Error"),
                                      message: Text("User's tweets could not be found"),
                                      dismissButton: .default(Text("OK")))
}
