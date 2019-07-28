//
//  CacheTest.swift
//  MindvalleyAppTests
//
//  Created by Zain Almasri on 7/23/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import XCTest
@testable import MindvalleyApp
@testable import CacheLibrary

class CacheTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	/// Test saving Data in storage
	func testSavingObject() {
		// save model
		let testObject = CachedData(url: "TestTest", data: Data.init(base64Encoded: "Test") ?? Data())
		try? storage.setObject(testObject, forKey: "TestTest", expiry: .never)
		// retrieve model
		let dataCached = try? storage.object(forKey: "TestTest")
		if dataCached?.data ?? Data() ==  Data.init(base64Encoded: "Test"){
			XCTAssertTrue(true)
		} else {
			XCTAssertTrue(false)
		}
	}

}
