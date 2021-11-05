//
//  HomeViewModel.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var tweetImage: UIImage?
    @Published var isSheetSelected = false
    @Published var currentSheet: SheetContent?
}
