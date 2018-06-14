import XCTest

import ErrandsTests

var tests = [XCTestCaseEntry]()
tests += ErrandsTests.allTests()
tests += ErrandsMemoryTests.allTests()
XCTMain(tests)
