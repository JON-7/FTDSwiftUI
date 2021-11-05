//
//  ScanImageView.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

struct ScanImageView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            CustomColor.backgroundColor.ignoresSafeArea()
            VStack {
                VStack {
                    Spacer()
                    
                    if let tweetImage = viewModel.tweetImage {
                        // Displays image that will be scanned
                            TweetImage(image: tweetImage)
                    }
                    
                    // Scan Button
                    Button {
                        
                    } label: {
                        ScanButton()
                    }
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.85,
                   height: UIScreen.main.bounds.height * 0.6)
            .background(Color(.systemBackground).opacity(0.4))
            .cornerRadius(12)
            .shadow(radius: 40)
            .overlay(
                Button {
                    dismiss()
                } label: {
                    XButton()
                }, alignment: .topTrailing)
        }
    }
}

struct ScanImageView_Previews: PreviewProvider {
    static var previews: some View {
        ScanImageView(viewModel: HomeViewModel())
            .preferredColorScheme(.dark)
    }
}

struct XButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
                .opacity(0.6)
            
            Image(systemName: "xmark")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundColor(.black)
        }
    }
}

struct ScanButton: View {
    var body: some View {
        Text("Scan")
            .frame(width: UIScreen.main.bounds.width * 0.6,
                   height: 50)
            .foregroundColor(.white)
            .background(Color("tweetColor"))
            .font(.title2)
            .cornerRadius(12)
            .padding(.top, 20)
    }
}

struct TweetImage: View {
    @State var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(12)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
    }
}
