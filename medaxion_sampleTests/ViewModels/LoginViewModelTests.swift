//
//  LoginViewModelTests.swift
//  medaxion_sampleTests
//
//  Created by Casey West on 11/9/23.
//

import XCTest

@testable import medaxion_sample
class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!
    var mockAuthService: MockAuthenticationService!

    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationService(shouldReturnSuccess: true)
        viewModel = LoginViewModel(authService: mockAuthService)
    }

    override func tearDown() {
        viewModel = nil
        mockAuthService = nil
        super.tearDown()
    }

    //MARK: - Tests
    // Test successful login with valid credentials
    func testLoginSuccessWithValidCredentials() {
        viewModel.username = "validUser"
        viewModel.password = "validPassword"

        let expectation = self.expectation(description: "Login should succeed with valid credentials")

        viewModel.login { success in
            XCTAssertTrue(success, "Expected successful login")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Test failed login with invalid credentials
    func testLoginFailureWithInvalidCredentials() {
        viewModel.username = "invalidUser"
        viewModel.password = "invalidPassword"
        mockAuthService.shouldReturnSuccess = false

        let expectation = self.expectation(description: "Login should fail with invalid credentials")

        viewModel.login { success in
            XCTAssertFalse(success, "Expected failed login")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Test that correct credentials are passed to the authentication service
    func testCorrectCredentialsPassedToAuthService() {
        let testUsername = "testuser"
        let testPassword = "testpassword"
        viewModel.username = testUsername
        viewModel.password = testPassword

        viewModel.login { _ in }

        XCTAssertEqual(mockAuthService.receivedUsername, testUsername, "Username passed to service should match")
        XCTAssertEqual(mockAuthService.receivedPassword, testPassword, "Password passed to service should match")
    }

    // Test login with nil username
    func testLoginWithNilUsername() {
        viewModel.username = nil
        viewModel.password = "password"

        let expectation = self.expectation(description: "Login should fail with nil username")

        viewModel.login { success in
            XCTAssertFalse(success, "Login should fail when username is nil")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Test login with nil password
    func testLoginWithNilPassword() {
        viewModel.username = "username"
        viewModel.password = nil

        let expectation = self.expectation(description: "Login should fail with nil password")

        viewModel.login { success in
            XCTAssertFalse(success, "Login should fail when password is nil")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Test login with both username and password nil
    func testLoginWithNilUsernameAndPassword() {
        viewModel.username = nil
        viewModel.password = nil

        let expectation = self.expectation(description: "Login should fail with nil username and password")

        viewModel.login { success in
            XCTAssertFalse(success, "Login should fail when both username and password are nil")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // Additional test cases...
}
