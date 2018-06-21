[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-4E4E4E.svg?colorA=28a745)](#installation)
[![Swift support](https://img.shields.io/badge/Swift-3.1%20%7C%203.2%20%7C%204.0%20%7C%204.1-lightgrey.svg?colorA=28a745&colorB=4E4E4E)](#swift-versions-support)

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Errands.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Errands)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/apple/swift-package-manager)

[![Twitter](https://img.shields.io/badge/Twitter-@warcholuke-blue.svg?style=flat)](http://twitter.com/warcholuke)

# Errands
Quick and simple way of running sequential asynchronous tasks.

Need for Errands came while building integration tests suite for [Tunsgten](https://tungstenapp.com) project. Usually those tests consist of multiple sequential operations, where each step depends on results from previous step. Nevertheless testing usecase is not the only one that Errands could be used for.

Note: Errands and [PromisKit](https://github.com/mxcl/PromiseKit) share similarities in functionality. Errands put strong focus on creating custom operations quicker in expense of being less powerful.

## Usage
Running you firts Errands sequence is as simple as follows:

```swift
Errands().first { (done: @escaping DoneClosure<Void>) in
  print("begin")
  done(())
}.then { (_, done: @escaping DoneClosure<Void>) in
  print("step")
  done()
}.finally {
  print("done")
}
```

True value of Errands comes with easy information passing between steps. Following example logs in an user and loads her contacts.

```swift
Errands().first { (done: @escaping DoneClosure<User>) in
  api.login(credentials) { user
    done(user)
  }
}.then { (loggedInUser, done: @escaping DoneClosure<[Contact]]>) in
  api.loadContacts(loggedInUser) { contacts in
    done(contacts)
  }
}.finally { contacts in
  print("User contacts: \(contacts).")
}
```

## Installation

#### Cocoapods
To integrate Errands using [Cocoapods](http://cocoapods.org/), specify it as a dependency in your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
  pod 'Errands'
end
```

Then, install it by running the following command:
```shell
$ pod install
```

#### Carthage
To integrate Errands using [Carthage](https://github.com/Carthage/Carthage), specify it as a dependency in your `Cartfile`:
```
github "lukewar/Errands" ~> 0.1.0
```
Run carthage update to build the framework and drag the built Errands.framework into your Xcode project.

#### Swift Package Manager
To integrate Errands using [Swift Package Manager](https://swift.org/package-manager/), specify it as a dependency in your `Package.swift`:
```swift
dependencies: [
  .package(url: "https://github.com/lukewar/Errands.git", .upToNextMinor(from: "0.1.0"))
]
```

## Contribution

Please submit Pull Request against current development branch.

## Licence
The MIT License (MIT)

Copyright (c) 2018 Lukasz Warchol

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.