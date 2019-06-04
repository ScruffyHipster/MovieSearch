# Movie Search

Movie Search uses native technologies to create a simplistic user experience. A user can enter a search parameter, then view the results of a call to the **OMDB API** in a collection view. The user can then save the result for later viewing, or research a recent parameter. The data also persists between app restarts and works on both iPhone and iPad. I developed the application with the aim that another developer would be able to pick it up and understand and maintain it with minimal fuss all while retaining a solid architecture.

### Screenshots

![mainiPhone](https://user-images.githubusercontent.com/14076860/58883985-68737b00-86d7-11e9-996b-8845124a1fe3.png) ![searchField](https://user-images.githubusercontent.com/14076860/58884021-788b5a80-86d7-11e9-9f0d-7267ff677430.png) ![results](https://user-images.githubusercontent.com/14076860/58884054-87720d00-86d7-11e9-8b23-2d4f56c9ac62.png) ![searchresult](https://user-images.githubusercontent.com/14076860/58884085-95c02900-86d7-11e9-822a-c2023a535e9d.png)

### Architecture

##### Coordinator pattern coupled with MVC

The app architecture uses the coordinator pattern using MVC. The Coordinator pattern allows for flexibility, readability and reusability. I see this is as a pattern that allows for clean production-ready code that's easy to understand. 

The application utilises storyboard while the UI has been programmatically. I chose this route to provide flexibility to any other future developers working on the app.

A hybrid approach allows for both styles of UI design. I wanted to be accommodating where I could for any future devs that work on this project. If they build in storyboard or programmatically, they would be able to add to this application.

The Coordinator pattern also helps reduce the problems that the MVC pattern has. The massive view controller. Each controller has a coordinator, which allows it to remain modular and independent. The Coordinator acts as a delegate in which the logic and flow of the application are determined. This provides a more flexible, readable, reusable and modular approach.

### Persistence

##### Core Data & FileManager

In the application, I've used two separate methods of persisting data during app restarts. I chose two approaches as they have benefits for their use cases.

I used Core Data for persisting the saved searches information. I felt as each instance of saving a search result had many elements to save. Core Data provided a native, easy to use and install the solution. As while not used as much in comparison to other cloud-based solutions such as CloudKit or Firebase. I wanted the application to be straight out of the box solution in this particular scenario. In an app store application, I would look to use CloudKit if an iOS exclusive. Usually, iOS users are iCloud account holders and so data could be saved to iCloud with minimal setup by the user, or by having to sign up or in. Core Data also has plenty of available up to date documentation. 

For the previous searches, I opted to use FileManager and NSKeyArchive. CoreData wouldn’t have been an effective solution and I felt it was overkill. As FileManager was already used to save images downloaded from the search request. It felt right to continue to save the simple array to the device's disk. It's also easy to amend and keep up to date with little effort. Again, this is native and well documented. Which means that any future dev could find relevant information if required. 

### Third Party Libraries

Library used: [Motion](https://github.com/CosmicMind/Motion)

I opt to try and use native where ever I can, yet, I also wanted to prove an understanding of Cocoa Pods. How to install them and use of dependencies in a project. 

So I used Motion, a library which provides animations for transitions and for UIViews. I wanted differing transitions in the application. So it made sense to use a library where I could create them with ease and speed. I decided to not use all the functionality. Deciding instead to omit any reliance on its animation offerings for UIView animations. For this I opted for Core Animation instead, I'm more comfortable with this approach. 

The library is well maintained and updated on a regular basis. There are direct channels of communication with the creator for support. Discussions on stack overflow and they appear to be open to pull requests.

For this project, it made sense to install this library. But, in a production application. There should always be a pragmatic and thought out approach when deciding to use a third party library over a native solution. Especially if it's integral to the application's functionality. 

### Using the application

- Upon startup tap the search field which will show the keyboard.
- Type in a search parameter and then tap return on the keyboard to start the search. If a search has been made before, the previous searches will show up below the search field. Tap this to populate the field and then tap return. 
- If successful the application will then display the results in a collection view. 
- Tap on an image to see more information about the desired movie. 
- If you would like to save the movie for later viewing, tap the like icon in the upper right-hand corner. 
- To view saved results, tap the saved tab on the tab bar controller. 
- Then tap an item on the list to see the movie you’ve like to revisit. 
- If you’d like to remove that search uses the swipe to delete to remove it from the saved results. 
