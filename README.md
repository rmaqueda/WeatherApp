# Weather App

It's an IOS project written in Swift. The challenge is to develop a weather application with similar UI as Apple one and following some of the rules of [clean architecture](https://pusher.com/tutorials/clean-architecture-introduction) and a large test coverage.

The intentions of this repo is not to show the simplest way to create an iOS app, there're some extra techniques maybe not ready for a production product. Here I'm showing and practicing some stuffs I'm learning.

If you have any feedback I would love to hear it!

## How to build

The project just uses Cocoa Frameworks but I'd want to add some three party libraries like Google Firebase stack (Analytics, Crashlytics, Performance) as an example. I used Cocoapod to manage these dependencies, so to build the project you will need:

```
# git clone https://github.com/rmaqueda/WeatherApp
# cd WeatherApp
# pod install
# open WeatherApp.xcworkspace
```

The first time you build the project with Xcode will fail and ask you to enter the Open Weather API Key, this logic happens in a build script  [👀](https://github.com/rmaqueda/WeatherApp/blob/main/Scripts/Build-Phases/copy_secrets.sh).

You can get an API Key [here](https://openweathermap.org/api).

Here a brief description of the main topics:

## Architecture

The architecture has these layers per module:

- **ViewController**: Subscribe to ViewModel Combine Publisher to get the data or send events.

- **ViewModel**: Create view representable objects using a mapper and responses to ViewController events.

- **Interactor**: An optional layer (depends of the complexity of the module) with the different use cases and business logic.

- **Repository**: Repository pattern to choose between different data providers.

- **DataProvider**: Get the data from data sources.

Additionally there're some common components like:

- **Wireframe**: Navigation controller and build the dependency of every module.

- **APIClient**: Generic API REST client over URLSession.

I've used Dependency Injection [👀](https://en.wikipedia.org/wiki/Dependency_injection) to helps testing so all the dependencies are injected in the initialisers.

Here an objects diagram of the Weather module:

<p align="center">
    <img src="https://github.com/rmaqueda/WeatherApp/raw/main/Documentation/Weather.png">
</p>

## Swift

The minimum developer target is iOS 13 because the project uses **Combine** and **Compositional Layout**.

## UI

I've used UIKit because I don't feel confident with SwiftUI yet to do something a bit complex, for example, Compositional Layout [👀 class](https://github.com/rmaqueda/WeatherApp/blob/main/WeatherApp/Module/Weather/ViewController/WeatherCollectionViewLayout.swift), but a good challenge would be refactor to SwiftUI. 

I've implemented a basic Dark Mode with Appearance Proxy and Color Set catalogue.

If you'd like to see some screenshots, the files created during snapshot testing is a good place [👀 folder](https://github.com/rmaqueda/WeatherApp/tree/main/WeatherAppSnapshotTests/Module/Weather/__Snapshots__/WeatherViewControllerSnapShotTests).

## Tests

I've added [TestSpy](https://github.com/f-meloni/TestSpy) util tool. This helps to create spy objects, records calls and assert some conditions.

I'm using [Sourcery](https://github.com/krzysztofzablocki/Sourcery) to auto-generate spy objects with a [👀 build script](https://github.com/rmaqueda/WeatherApp/blob/main/Scripts/Build-Phases/sourcery.sh).

There are four different test targets:

- **WeatherAppUnitTests**: Unit tests using spy objects and mock.

- **WeatherAppIntegrationTests**: Integration tests using HTTPStubProtocol to provide STUB network responses globally, then check how the ViewModel behaves.

- **WeatherAppUITests**: UI tests using a launch environment tag to set up the APP before start. Here we have two different kind of tests:
  
    -- UI Testing: These tests are checking if the view is shown as expected when the ViewModel emit an event (Success/Error).
  
    -- System test:  End to end, black box tests launching the application as it is and performing some actions to check their results at the UI layer.

- **WeatherAppSnapshotTests**: Snapshot tests comparing snapshots and recursive description of the UI.

The project is integrated with Jenkins and [Browserstack](https://www.browserstack.com/) and the Jenkins pipeline runs after detecting new commits in parallel on nine different devices:

- Simulators: iPhone SE 13.6, iPhone SE 14.0, iPad Air 2 13.6, iPad Air 2 14.0.  [👀 fastfile](https://github.com/rmaqueda/WeatherApp/blob/36dac4ae30a752a81a2db7ea256d2d093525edcd/fastlane/Fastfile#L20).

- Physical Devices: iPhone 12 14.1, iPhone 11 Pro 13.4, iPhone 11 14.0, iPad Air 4 14.1, iPhone SE 13.4. See [👀 build script](https://github.com/rmaqueda/WeatherApp/blob/36dac4ae30a752a81a2db7ea256d2d093525edcd/Scripts/browserstack.sh#L34).

## Code Quality

The project is integrated with [Sonar Cloud](https://sonarcloud.io/dashboard?id=rmaqueda_WeatherApp). The seven hours of technical deb detected by Sonar is because the test function names are not compliance test_given..._when..._then.... I'll figure out how fix it.

Here the dashboard:

<p align="center">
    <a href="https://sonarcloud.io/dashboard?id=rmaqueda_WeatherApp">
        <img title="" src="https://github.com/rmaqueda/WeatherApp/raw/main/Documentation/Sonar.png" width="508">
    </a>
</p>

SwiftLint is set up in all targets. [👀 rules](https://github.com/rmaqueda/WeatherApp/blob/main/.swiftlint.yml)

I've used [CPD](https://pmd.github.io/latest/pmd_userdocs_cpd.html) to detect duplicate code blocks automatically inline during developer time, this's pretty cool because you've an early idea of copy paste code block with a Xcode warnings.

## Continuous Integration

I've used Fastlane to simplify all the build and test commands [👀 Fastfile](https://github.com/rmaqueda/WeatherApp/blob/main/fastlane/Fastfile).

I've added the project to my own Jenkins instance in my tinny Raspberry Pi and set up a basic pipeline to test the project and set the status in Github [👀 Jenkinsfile](https://github.com/rmaqueda/WeatherApp/blob/main/Jenkinsfile).

Jenkins classic pipeline view:

<p align="center">
    <img src="https://github.com/rmaqueda/WeatherApp/raw/main/Documentation/Jenkins_old_view.png" width="708">
</p>

Jenkins Blue Ocean view:

<p align="center">
    <img src="https://github.com/rmaqueda/WeatherApp/raw/main/Documentation/Jenkins_blue_ocean.png" width="708">
</p>

Browserstack project:

<p align="center">
    <img src="https://github.com/rmaqueda/WeatherApp/raw/main/Documentation/browserstack.png" width="708">
</p>

## References

[Clean Architecture (Robert C. Martin)](https://www.amazon.co.uk/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164/ref=sr_1_1?crid=18D1XJ7R5NEHA&dchild=1&keywords=clean+architecture&qid=1613715956&sprefix=clean+ar%2Caps%2C257&sr=8-1).

[Xcode - better build phase scripts](https://mokacoding.com/blog/better-build-phase-scripts/).

[Simple networking library](https://github.com/gonzalezreal/SimpleNetworking).

[Swift PlantUML Xcode Extension](https://github.com/MarcoEidinger/SwiftPlantUML-Xcode-Extension).

[Swift snapshot testing](https://github.com/pointfreeco/swift-snapshot-testing).

[iOS Cell Registration & Reusing with Swift Protocol Extensions and Generics](https://gist.github.com/gonzalezreal/92507b53d2b1e267d49a).
