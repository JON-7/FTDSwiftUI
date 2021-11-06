//
//  ContentView.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor.ignoresSafeArea()
            
            VStack {
                AppImages.appLogo
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.6,
                           height: UIScreen.main.bounds.width * 0.6)
                    .padding(.top, 75)
                    .padding(.bottom, 50)
                
                Button {
                    viewModel.isSheetSelected = true
                    viewModel.currentSheet = .camera
                } label: {
                    FTDButton(title: "Take Photo")
                        .padding(.bottom, 30)
                }
                
                Button {
                    viewModel.isSheetSelected = true
                    viewModel.currentSheet = .photoLibrary
                } label: {
                    FTDButton(title: "Photo Library")
                }

                .fullScreenCover(isPresented: $viewModel.isSheetSelected) {
                    switch viewModel.currentSheet {
                    case .camera:
                        ImagePicker(viewModel: viewModel, sourceType: .camera)
                    case .photoLibrary:
                        ImagePicker(viewModel: viewModel, sourceType: .photoLibrary)
                    default:
                        ScanImageView(viewModel: viewModel)
                    }
                }
                
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
                    .padding()
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .foregroundColor(Color.tweetColor)
                    .font(.title2)
            }
            Spacer()
        }
    }
}

enum SheetContent {
    case photoLibrary
    case camera
    case scanImage
}
