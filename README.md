# Vehicles catalog
This app serves as a testing assignment for Senior Flutter Developer position. It reaches out for [public api](https://vpic.nhtsa.dot.gov/api/) to fetch the information about all known vehicles manufacturers if a form of infinite list and allows to request details about all makes of every individual manufacturer.

## Installation
1. install all the dependencies via:<br />
``flutter pub get``
2. generate missing code snippets <br />
``flutter pub run build_runner build``

## Structure
This app is designed with clean architecture. Generally it is separated into two folders
* [core](lib/core) – general purpose tools that can be used across the whole app, such as:
    * [entities](lib/core/entities) mostly for custom-made data structures 
    * [errors](lib/core/errors) for unified error handling
    * [localization](lib/core/localization) that holds translatable strings 
    * [logger](lib/core/logger), which name speaks for itself
    * [network](lib/core/network) provides the app with tools to interact with network-based data sources
    * [theme](lib/core/theme) that holds custom set of configurations and conventions for the visual elements
    * ubiquitous [utils](lib/core/utils) folder for helper functions
    * [widgets](lib/core/widgets) ui-kit with set of commonly used visual building blocks
    * and most importantly, [locator](lib/core/locator.dart) - service locator, a place, where all the dependencies are being injected, all instances and factories are being registered and the access to all of that is being shared
* [features](lib/features) - all the pieces of functionality, separated by their business domain. Since our app serves only two purposes, we have two features:
    * [manufacturers](lib/features/manufacturers) - operates with manufacturers, defines how we load, process and display them.
    * [makes](lib/features/makes) - basically the same thing, but operates with makes
    
Every feature is presented with 3 loosely coupled layers: __data__, __domain__ and __presentation__. They define the direction of data flow and serve different purposes
* __data__ layer includes logic of communication with the 'outer world' - databases, API's, cache, file system etc.
* __domain__ layer holds the pure business logic. Usually consists of abstractions and classes that operate those abstractions regardless of their implementations
* __presentation__ layer responsible, well, for presenting the app to the end user - rendering the UI, handling interactions with elements and navigation between screens

The data flows between these layers like this: __Data -> Domain <- Presentation__.
Domain doesn’t have any dependency on any other layer and mostly written with pure Dart with almost no external dependencies and frameworks.
However, data and presentation layers are well-aware of domain layer, whereas they still have no idea about each other.