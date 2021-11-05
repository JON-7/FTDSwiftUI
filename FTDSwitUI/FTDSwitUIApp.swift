//
//  FTDSwitUIApp.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

@main
struct FTDSwitUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewModel())
        }
    }
}
