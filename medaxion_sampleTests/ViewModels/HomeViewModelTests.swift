//
//  HomeViewModelTests.swift
//  medaxion_sampleTests
//
//  Created by Casey West on 11/10/23.
//

import XCTest
@testable import medaxion_sample

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockService: MockMarvelApiService!

    override func setUp() {
        super.setUp()
        mockService = MockMarvelApiService()
        viewModel = HomeViewModel(marvelApiService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    //MARK: - Tests
    // Test loading character list success
    func testFetchCharactersSuccess() {
        let expectation = self.expectation(description: "FetchCharactersSuccess")
        
        viewModel.loadCharacterList(offset: 0) { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 2, "Expected 2 characters")
                XCTAssertEqual(characters[0].name, "Iron Man", "Expected first character to be Iron Man")
                XCTAssertEqual(characters[1].name, "Hulk", "Expected second character to be Hulk")
            case .failure(_):
                XCTFail("Expected successful character fetch")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    // Test loading character list failure
    func testFetchCharactersFailure() {
        mockService.shouldReturnError = true
        mockService.error = NSError(domain: "TestError", code: -1, userInfo: nil)
        
        let expectation = self.expectation(description: "FetchCharactersFailure")

        viewModel.loadCharacterList(offset: 0) { result in
            if case .success(_) = result {
                XCTFail("Expected fetch to fail, but it succeeded")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
    
    // Test refreshing character list success
    func testRefreshCharacterListSuccess() {
        // Setup for success scenario
        let expectation = self.expectation(description: "RefreshCharacterListSuccess")

        viewModel.refreshCharacterList { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, self.mockService.mockCharacters.count, "Expected character count to match mock data count")
                XCTAssertEqual(characters.first?.name, self.mockService.mockCharacters.first?.name, "Expected first character's name to match")
            case .failure(_):
                XCTFail("Expected refresh to succeed, but it failed")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    // Test refreshing character list failure
    func testRefreshCharacterListFailure() {
        // Setup for failure scenario
        mockService.shouldReturnError = true
        mockService.error = NSError(domain: "TestError", code: -1, userInfo: nil)

        let expectation = self.expectation(description: "RefreshCharacterListFailure")

        viewModel.refreshCharacterList { result in
            if case .success(_) = result {
                XCTFail("Expected refresh to fail, but it succeeded")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    // Test that loading is blocked if already in progress
    func testLoadCharacterListWhenAlreadyLoading() {
        viewModel.isLoading = true

        let expectation = self.expectation(description: "Load should fail when already loading")

        viewModel.loadCharacterList(offset: 0) { result in
            if case .failure(let error as NSError) = result {
                XCTAssertEqual(error.domain, "")
                XCTAssertEqual(error.code, -1)
                XCTAssertEqual(error.userInfo[NSLocalizedDescriptionKey] as? String, "Already loading")
            } else {
                XCTFail("Expected failure due to already loading, but succeeded")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Test pagination scenario
    func testLoadCharacterListForPagination() {
        // Setup mock service to return a certain set of characters
        let initialCharacters = [MarvelCharacter(id: 1, name: "Iron Man", description: "A wealthy industrialist and genius inventor", resourceURI: nil, thumbnail: nil, comics: nil, stories: nil, events: nil, series: nil)]
        let newCharacters = [MarvelCharacter(id: 2, name: "Hulk", description: "A green behemoth", resourceURI: nil, thumbnail: nil, comics: nil, stories: nil, events: nil, series: nil)]
        
        mockService.mockCharacters = newCharacters

        // Initially load with some characters
        viewModel.characterList = initialCharacters

        let expectation = self.expectation(description: "Load additional characters for pagination")

        viewModel.loadCharacterList(offset: 1) { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, initialCharacters.count + newCharacters.count)
                XCTAssertEqual(characters.last?.name, "Hulk")
            case .failure(_):
                XCTFail("Expected successful character fetch for pagination")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Test successful completion with character list
    func testSuccessfulCompletionReturnsCharacters() {
        let testCharacters = [MarvelCharacter(id: 1, name: "Iron Man", description: "A wealthy industrialist and genius inventor", resourceURI: nil, thumbnail: nil, comics: nil, stories: nil, events: nil, series: nil)]

        mockService.mockCharacters = testCharacters

        let expectation = self.expectation(description: "Successful completion should return characters")

        viewModel.loadCharacterList(offset: 0) { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters, testCharacters)
            case .failure(_):
                XCTFail("Expected successful character fetch")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    //Additional test cases...
}

