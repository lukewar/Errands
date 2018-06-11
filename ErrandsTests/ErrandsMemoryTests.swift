//
//  Copyright © 2018 Lukasz Warchol. All rights reserved.
//

@testable import Errands
import XCTest

class ErrandsMemoryTests: XCTestCase {
    // week reference to test object cleanup
    weak var sut: Errands?

    override func tearDown() {
        XCTAssertNil(sut)
        super.tearDown()
    }

    func testSyncronousExecution() {
        var tmp: Errands? = Errands()
        sut = tmp
        sut!.first { (done: @escaping DoneClosure<Void>) in
            print("begin")
            done(())
        }.then { (_, done: @escaping DoneClosure<Void>) in
            print("step 1")
            done(())
        }.finally {
            print("done")
        }

        tmp = nil
    }

    func testEmptyErrandsCleanup() {
        var tmp: Errands? = Errands()
        sut = tmp
        tmp = nil
    }

    func testAsyncronousExecution() {
        let expectation = XCTestExpectation(description: "Asynchronous expectation")

        var tmp: Errands? = Errands()
        sut = tmp
        sut!.first { (done: @escaping DoneClosure<Void>) in
            print("begin")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: done)
        }.then { (_, done: @escaping DoneClosure<Void>) in
            print("step 1")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: done)
        }.finally {
            expectation.fulfill()
            print("done")
        }

        tmp = nil

        wait(for: [expectation], timeout: 10)
    }
}
