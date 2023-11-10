//
//  AuthenticationServiceTests.swift
//  medaxion_sampleTests
//
//  Created by Casey West on 11/9/23.

import XCTest

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
    
    // tearDownWithError() is called after the invocation of each test method in the class.
    override func tearDownWithError() throws {
        // Clean up by nullifying authService.
        authService = nil
        try super.tearDownWithError()
    }
    
    
}
