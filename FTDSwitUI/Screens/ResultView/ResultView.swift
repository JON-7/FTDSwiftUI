//
//  ResultView.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

struct ResultView: View {
    
    @StateObject var viewModel = ResultViewModel()
    @State var tweetBody: TweetBody
    
    var body: some View {
        ZStack {
            Color.mainBackgroundColor.ignoresSafeArea()
            
            ZStack {
                VStack {
                    
                    Text(viewModel.isTweetReal ? "REAL TWEET" : "FAKE TWEET")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .foregroundColor(viewModel.isTweetReal ? .green : .red)
                    
                    Image(viewModel.isTweetReal ? AppImages.realTweet : AppImages.fakeTweet)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.7,
                               height: UIScreen.main.bounds.width * 0.35)
                    
                    TweetComponentResult(title: "Username",
                                         text: tweetBody.username,
                                         isTweetReal: viewModel.isTweetReal)
                    
                    TweetComponentResult(title: "Date",
                                         text: tweetBody.stringDate,
                                         isTweetReal: viewModel.isTweetReal)
                    
                    TweetComponentResult(title: "Tweet",
                                         text: tweetBody.tweetText,
                                         isTweetReal: viewModel.isTweetReal)
                    
                    Spacer()
                    
                    Button {
                        viewModel.isSheetSelected = true
                    } label: {
                        FTDButton(title: "Scan Again")
                    }
                    .fullScreenCover(isPresented: $viewModel.isSheetSelected) {
                        HomeView()
                    }
                }
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(
                        Text("OK"),
                        action: {
                            viewModel.isSheetSelected = true
                        }))
            }
        }
        .onAppear {
            setupView()
        }
    }
    
    func setupView() {
        viewModel.isLoading = true
        viewModel.getTwitterID(username: tweetBody.username) { id in
            
            viewModel.getUserTweets(id: id, startTime: tweetBody.date.dayBefore.toString, endTime: tweetBody.date.dayAfter.toString) { tweets in
                
                viewModel.findTweet(imageText: tweetBody.tweetText, userTweets: tweets.data) { result in
                    DispatchQueue.main.async {
                        self.viewModel.isTweetReal = !result.isEmpty
                        self.viewModel.isLoading = false
                        if result.isEmpty {
                            self.tweetBody.tweetText = "Tweet Not Found"
                        } else {
                            self.tweetBody.tweetText = result
                        }
                    }
                }
            }
        }
    }
}

struct TweetComponentResult: View {
    var title: String
    var text: String
    var isTweetReal: Bool
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: UIScreen.main.bounds.height * 0.04,
                                  weight: .semibold))
                    .fontWeight(.semibold)
                    .underline()
                    .foregroundColor(isTweetReal ? .green : .red)
                
                Text(text)
                    .font(.system(size: UIScreen.main.bounds.height * 0.04,
                                  weight: .light))
                    .minimumScaleFactor(0.7)
            }
            .padding()
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.mainBackgroundColor
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.tweetColor)
                .scaleEffect(3)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(tweetBody: TweetBody(username: "", tweetText: "", stringDate: "", date: Date()))
            .preferredColorScheme(.dark)
    }
}
