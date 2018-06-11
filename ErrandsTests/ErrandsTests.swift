//
//  Copyright © 2018 Lukasz Warchol. All rights reserved.
//

@testable import Errands
import XCTest

class ErrandsTests: XCTestCase {
    var sut: Errands!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSyncronousExecution() {
        sut = Errands()
        sut.first { (done: @escaping DoneClosure<Void>) in
            print("begin")
            done(())
        }.then { (_, done: @escaping DoneClosure<String>) in
            print("step 2")
            done("completed")
        }.finally {
            print("done")
        }
    }

    func testAsyncronousExecution() {
        let expectation = XCTestExpectation(description: "Asynchronous expectation")

        sut = Errands()
        sut.first { (done: @escaping DoneClosure<Void>) in
            print("begin")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: done)
        }.then { (_, done: @escaping DoneClosure<String>) in
            print("step 1")
            done("completed")
        }.finally {
            expectation.fulfill()
            print("done")
        }

        wait(for: [expectation], timeout: 2)
    }
}
