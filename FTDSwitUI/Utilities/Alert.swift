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
    
    static let invalidPicture = AlertItem(title: Text("Invalid Image"),
                                          message: Text("Please choose another picture."),
                                          dismissButton: .default(Text("OK")))
}
