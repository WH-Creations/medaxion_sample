//
//  AuthenticationServiceTests.swift
//  medaxion_sampleTests
//
//  Created by Casey West on 11/9/23.

import XCTest
@testable import medaxion_sample

class AuthenticationServiceTests: XCTestCase {
    
    // Mock AuthenticationService to be used in tests.
    var authService: MockAuthenticationService!
    // Test credentials.
    var usernameToTest = "test"
    var passwordToTest = "password"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Initialize the mock service with the default expectation of failure.
        authService = MockAuthenticationService(shouldReturnSuccess: false)
    }
    
    override func tearDownWithError() throws {
        // Clean up by nullifying authService.
        authService = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Tests
    // Test case: Attempting login with an empty username should fail.
    func testLoginWithEmptyUsername() {
        executeLoginTest(username: "", password: passwordToTest, expectedSuccess: false, description: "Login with empty username should fail")
    }
    
    // Test case: Attempting login with an empty password should fail.
    func testLoginWithEmptyPassword() {
        executeLoginTest(username: usernameToTest, password: "", expectedSuccess: false, description: "Login with empty password should fail")
    }
    
    // Test case: Attempting login with incorrect credentials should fail.
    func testLoginWithIncorrectCredentials() {
        authService.shouldReturnSuccess = false // Simulate failure due to incorrect credentials.
        executeLoginTest(username: usernameToTest, password: "wrongpassword", expectedSuccess: false, description: "Login with incorrect credentials should fail")
    }
    
    // Test case: A successful login should return a success flag.
    func testLoginSuccess() {
        authService.shouldReturnSuccess = true // Simulate a successful login.
        executeLoginTest(username: usernameToTest, password: passwordToTest, expectedSuccess: true, description: "Expect successful login.")
    }
    
    // Test case: A failed login should return a failure flag.
    func testLoginFailure() {
        authService.shouldReturnSuccess = false // Simulate a failed login.
        executeLoginTest(username: usernameToTest, password: passwordToTest, expectedSuccess: false, description: "Expect unsuccessful login.")
    }
    
    //MARK: - Helpers
    // A generic function to execute a login test.
    // Parameters:
    // - username: The username for login.
    // - password: The password for login.
    // - expectedSuccess: The expected success or failure of the login.
    // - description: Description for the XCTestExpectation.
    private func executeLoginTest(username: String, password: String, expectedSuccess: Bool, description: String) {
        let expectation = XCTestExpectation(description: description)
        
        authService.login(username: username, password: password) { success in
            // Assert the success flag is as expected.
            XCTAssertEqual(success, expectedSuccess, "Expected \(expectedSuccess) but got \(success)")
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled within a timeout.
        wait(for: [expectation], timeout: 2.0)
    }
}
