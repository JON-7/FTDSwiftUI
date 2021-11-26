# Fake Tweet Detector
- SwiftUI application that allows users to verify the authenticity of a tweet found online
- Users can either take a photo of a tweet or choose one from their camera roll

## App Previews: 
Home Screen             |  Result
:-------------------------:|:-------------------------:|
![](https://i.ibb.co/C7JM8DF/IMG-921691-EAB155-1.jpg) | ![](https://i.ibb.co/b2LbNwP/IMG-EA16-FF91-CBB4-1.jpg) |

# Image of Tweet
![](https://i.ibb.co/hgptTHz/Screen-Shot-2021-08-15-at-10-35-28-PM.png)

## About the project
- Retrieves text from an image using Apple's Vision framework
- Uses Twitter's API to search for a tweet
- A tweet is classified as authentic if Twitter's API returns a valid tweet matching the text from the image
