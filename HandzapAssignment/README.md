//
//  README.md
//  HandzapAssignment
//
//  Created by Nadeem Akram on 12/01/2020.
//  Copyright © 2019 Nadeem Akram. All rights reserved.
//

 1. HandzapAssignment
HandzapAssignment by Nadeem Akram (nadeemakram2388@gmail.com)  from Handzap  (careers@handzap.com).


 2. Requirements
- iOS 10.0+
- [Xcode 10.1](https://download.developer.apple.com/Developer_Tools/Xcode_10.1/Xcode_10.1.xip) 
- [CocoaPods](https://cocoapods.org/)
- [Fastlane](https://fastlane.tools)(Optional)

 3. Getting Start
- Open `HandzapAssignment.xcworkspace` in Xcode 10.1
- Build the project

 4. Problem Statements
[Zeplin] (https://zpl.io/2pjYo8Q)

 5. Swift
This project is build using Swift 4.2.

 6. 3rd Party
- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)

​ 7. This project only using IQKeyboardManager 3rd party dependency. Because less 3rd party means higher selection chances. I added this 3rd party just to demonstrate the use of the dependency manager (cocoapods).

​## 8. Architecture
​In this project, I'm using MVVM architecture without any Reactive 3rd party lib(like RxSwift etc.). FormList population, I am using CoreData (NSFetchResultContorller) for reactive effect. 
​
​## 9. Memory Management
​![](ReferanceDoc/MemoryLeaks.png)
​
​## 10. Extra Feature
​I'm using CoreData to store form locally since there is no WebService right now.
​
