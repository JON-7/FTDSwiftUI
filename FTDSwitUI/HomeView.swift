//
//  ContentView.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            CustomColor.backgroundColor
                .ignoresSafeArea()
            VStack {
                Image(AppImages.appLogo)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.6,
                           height: UIScreen.main.bounds.width * 0.6)
                    .padding(.top, 75)
                    .padding(.bottom, 50)
                
                FTDButton(title: "Take Photo")
                    .padding(.bottom, 30)
                
                FTDButton(title: "Photo Library")
                
                Spacer()
                
                InfoButton()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

struct InfoButton: View {
    var body: some View {
        HStack {
            Button {
                //action
            } label: {
                Image(systemName: AppImages.infoCircle)
                    .renderingMode(.original)
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .foregroundColor(CustomColor.tweetColor)
                    .font(.title2)
            }
            Spacer()
        }
    }
}
