Rick and Morty Explorer

Rick and Morty Explorer is an iOS application designed to explore characters from the popular TV series Rick and Morty. The app leverages the Rick and Morty API to fetch character details and provides a user-friendly interface for seamless navigation and data exploration.

Features

Tab-Based Navigation: The app utilizes UITabBarController for intuitive navigation between different sections of the application.
Hierarchical Navigation: Powered by UINavigationController, users can drill down into character details and other related information.
Character Filtering: A dropdown filter lists all available planets. Selecting a planet filters characters by their associated origin.
Offline Data Storage: The app uses CoreData for local data persistence, ensuring users can view previously fetched data offline.
Responsive Design: The UI is crafted to align with the provided design specifications ([Figma link](https://www.figma.com/file/izqUFxs6GfORR6NPAAon3k/Untitled?type=design&node-id=0%3A1&mode=design&t=rG9gJ7tjSGDtgN6b-1)).

Architecture

The application follows the Model-View-Controller (MVC) architectural pattern:

Model: Handles data, including API integration and CoreData storage.
View: Represents the user interface components as defined in the Figma design.
Controller: Manages the interaction between the Model and the View, handling user input and updating the UI accordingly.

Technical Stack

Networking: Built on the Rick and Morty API for fetching character data.
CoreData: Used for efficient local data storage and retrieval.
UIKit: Implements custom UI elements with UITabBarController and UINavigationController.
