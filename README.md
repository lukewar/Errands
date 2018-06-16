[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-4E4E4E.svg?colorA=28a745)](#installation)
[![Swift support](https://img.shields.io/badge/Swift-3.1%20%7C%203.2%20%7C%204.0%20%7C%204.1-lightgrey.svg?colorA=28a745&colorB=4E4E4E)](#swift-versions-support)

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Errands.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Errands)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/apple/swift-package-manager)

[![Twitter](https://img.shields.io/badge/Twitter-@warcholuke-blue.svg?style=flat)](http://twitter.com/warcholuke)

# Errands
Quick and simple way of running sequential asynchronous tasks.

Errands originated from need to simplify creation of integration tests. Those tests consist of multiple sequential operations, where each step depends on results from previous step. Altho tests use case is not the only one that Errands could be used.

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

It is very easy to pass values between steps. Following example logs in user and loads her contacts.

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

#### Carthage

#### Swift Package Manager

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