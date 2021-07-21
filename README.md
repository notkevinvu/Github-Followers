# Github-Followers
Demo app using the github API to retrieve and filter publicly available github users and followers

\*DISCLAIMER\* - This was created based off of Sean Allen's version of the app. I have put my own spin on it (technically) for me to learn and reinforce my iOS/Swift fundamentals.

## Breakdown of the app
An iOS app that allows users to search usernames on GitHub to look at followers for that user and to see more information on those followers. Also allows you to favorite any user to search them on demand.

I built this app entirely in Swift, using UIKit and MVC for the architecture of the app. Utilized Apple's human interface guidelines to guide UI decisions like font size, font type (utilizing dynamic type for users that need or want to scale the font of text for accessibility reasons), colors (dark mode enabled!), and touch target sizes. 

The app makes numerous network calls to the Github API to retrieve information on users and followers, which we make possible through usage of Apple's native URLSession framework, with which we construct our own API on top of for easier usage by developers (me!). We work within the guidelines of the Github API, implementing pagination into our networking API and business logic so that we don't overload the server with requests. On top of this, to make sure we don't ruin the user experience while scrolling through the app, I implement a simple image cache so that we don't need to continually download images (reducing load for image downloading and improving the UX while scrolling by a significant amount, depending how much the user scrolls). I make use of the Codable functionality in Swift's Foundation framework to parse through the JSON from the Github API and load it into the app, where I transform it into UI presentable elements. 

I also focus on creating reusable components for use throughout the app for efficiency and clean code. Finally, I utilize the UserDefaults class to store important favorites information for persistence.

## App Screenshots

<img src="https://user-images.githubusercontent.com/50222947/118077128-847efd00-b381-11eb-8b2f-bfe6d4cf5863.png" width="250"> <img src="https://user-images.githubusercontent.com/50222947/118077135-88ab1a80-b381-11eb-9995-19e6557b91ed.png" width="250"> <img src="https://user-images.githubusercontent.com/50222947/118077141-8a74de00-b381-11eb-82fd-cb789a8af380.png" width="250"> <img src="https://user-images.githubusercontent.com/50222947/118077147-8cd73800-b381-11eb-8979-e4d807eef0c4.png" width="250"> <img src="https://user-images.githubusercontent.com/50222947/118077152-906abf00-b381-11eb-906b-8b122d2e5c60.png" width="250">
