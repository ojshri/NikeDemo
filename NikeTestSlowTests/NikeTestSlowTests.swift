//
//  NikeTestSlowTests.swift
//  NikeTestSlowTests
//
//  Created by Oj Shrivastava on 11/19/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import XCTest
@testable import NikeTest

class NikeTestSlowTests: XCTestCase {
    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToiTunesGetsHTTPStatusCode200() {
        
        // given
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/30/explicit.json")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        // 3
        wait(for: [promise], timeout: 5)
    }
    
    // Asynchronous test: faster fail
    func testCallToiTunesCompletes() {
        
        // given
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/30/explicit.json")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
