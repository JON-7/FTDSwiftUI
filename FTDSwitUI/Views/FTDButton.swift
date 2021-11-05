//
//  FTDButton.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

struct FTDButton: View {
    var title: String
    
    var body: some View {
        Text(title)
            .frame(width: UIScreen.main.bounds.width * 0.9,
                   height: 60)
            .foregroundColor(.white)
            .background(Color("tweetColor"))
            .font(.title2)
            .cornerRadius(30)
    }
}

struct FTDButton_Previews: PreviewProvider {
    static var previews: some View {
        FTDButton(title: "BUTTON")
    }
}
