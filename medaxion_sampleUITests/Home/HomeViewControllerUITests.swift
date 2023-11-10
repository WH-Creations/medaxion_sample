//
//  HomeViewControllerUITests.swift
//  medaxion_sampleUITests
//
//  Created by Casey West on 11/10/23.
//
import XCTest

class HomeViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        // Ensures the app runs in UI Test mode
        app.launchArguments = ["--UITesting-HomeViewController"]
        app.launch()
    }

    // Test if the HomeViewController loads and displays its main UI components
    func testHomeViewControllerLoadsProperly() {
        // Verify if the main view of HomeViewController is loaded
        let homeView = app.otherElements["HomeViewIdentifier"]
        XCTAssertTrue(homeView.waitForExistence(timeout: 1), "HomeViewController's view should be present")

        // Verify the presence of the collection view
        let collectionView = app.collectionViews["HomeCollectionViewIdentifier"]
        XCTAssertTrue(collectionView.exists, "Collection view should exist in HomeViewController")

        // Additional checks can be performed here for other UI components like navigation bar title, buttons, etc.
    }
    
    // Test if the collection view displays the correct number of items
    func testCollectionViewDisplaysCorrectNumberOfItems() {
        let collectionView = app.collectionViews["HomeCollectionViewIdentifier"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5), "Collection view should be present")

        // Define an expectation for the number of cells to be loaded
        let expectedCellCount = 2 // Expected number of items
        let predicate = NSPredicate(format: "count == \(expectedCellCount)")
        
        // Use XCTNSPredicateExpectation
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: collectionView.cells)

        // Wait for the expectation to be fulfilled, with a timeout
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)

        // Now that the expectation is fulfilled or timed out, assert the cell count
        let cellCount = collectionView.cells.count

        // Check result of the wait operation to decide if the test should fail
        if result == .completed {
            XCTAssertEqual(cellCount, expectedCellCount, "Collection view should have \(expectedCellCount) items")
        } else {
            XCTFail("Failed to load the expected number of items within the timeout")
        }
    }


    // Test the behavior of the refresh control
    func testRefreshControlBehavior() {
        let collectionView = app.collectionViews["HomeCollectionViewIdentifier"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 1), "Collection view should be present")

        // Initiate a refresh action
        collectionView.swipeDown()

        // Add assertions to check the response of the UI to the refresh action.
        // This might include verifying a loading indicator, changes in the collection view, etc.
        // Example:
        // XCTAssertTrue(collectionView.staticTexts["LoadingIndicator"].exists, "Loading indicator should appear during refresh")
    }

    // Additional test cases can be added to cover more interactions and scenarios
}
