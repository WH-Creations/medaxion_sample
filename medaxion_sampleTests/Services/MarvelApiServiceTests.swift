//
//  MarvelApiServiceTests.swift
//  medaxion_sampleTests
//
//  Created by Casey West on 11/10/23.
//

import XCTest
@testable import medaxion_sample

final class MarvelApiServiceTests: XCTestCase {

    var mockService: MockMarvelApiService!

    override func setUp() {
        super.setUp()
        mockService = MockMarvelApiService()
    }

    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    //MARK: - Tests
    func testMarvelApiServiceSuccessFetch() {
        // Arrange
        mockService.mockCharacters = [
            MarvelCharacter(id: 1, name: "Iron Man", description: "A wealthy industrialist and genius inventor", resourceURI: nil, thumbnail: nil, comics: nil, stories: nil, events: nil, series: nil),
            MarvelCharacter(id: 2, name: "Hulk", description: "A green behemoth", resourceURI: nil, thumbnail: nil, comics: nil, stories: nil, events: nil, series: nil)
        ]

        let expectation = self.expectation(description: "MarvelApiServiceSuccessFetch")

        // Act
        mockService.getMarvelCharacters(offset: 0) { result in
            // Assert
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 2)
                XCTAssertEqual(characters.first?.name, "Iron Man")
            case .failure(_):
                XCTFail("Expected success, but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testMarvelApiServiceFailureFetch() {
        // Arrange
        mockService.shouldReturnError = true
        mockService.error = NSError(domain: "TestError", code: -1, userInfo: nil)

        let expectation = self.expectation(description: "MarvelApiServiceFailureFetch")

        // Act
        mockService.getMarvelCharacters(offset: 0) { result in
            // Assert
            if case .success(_) = result {
                XCTFail("Expected failure, but got success")
            } else {
                // Test passed: service correctly reported an error
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Additional test cases...
}
