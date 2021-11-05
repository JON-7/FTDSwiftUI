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
            CustomColor.backgroundColor.ignoresSafeArea()
            
            VStack {
                Image(uiImage: AppImages.appLogo)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.6,
                           height: UIScreen.main.bounds.width * 0.6)
                    .padding(.top, 75)
                    .padding(.bottom, 50)
                
                Button {
                    //viewModel.isSheetSelected = true
                } label: {
                    FTDButton(title: "Take Photo")
                        .padding(.bottom, 30)
                }
                
                Button {
                    viewModel.isSheetSelected = true
                    viewModel.currentSheet = .imagePicker
                } label: {
                    FTDButton(title: "Photo Library")
                }

                .fullScreenCover(isPresented: $viewModel.isSheetSelected) {
                    switch viewModel.currentSheet {
                    case .imagePicker:
                        ImagePicker(viewModel: viewModel)
                    case .scanImage:
                        ScanImageView(viewModel: viewModel)
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
                    .foregroundColor(CustomColor.tweetColor)
                    .font(.title2)
            }
            Spacer()
        }
    }
}

enum SheetContent {
    case imagePicker
    case scanImage
}


struct SomeView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var image: Image?
    
    var body: some View {
        ZStack {
            
            Color.gray.ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Circle()
                            .fill(.white)
                            .frame(width: 50, height: 50)
                            .padding()
                            .overlay(
                                Image(systemName: "xmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            )
                    }
                    Spacer()
                }
                
                Spacer()
                
                Text("SOME VIEW")
                image?
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                    .scaledToFit()
                
                Spacer()
                
            }
        }
    }
}
