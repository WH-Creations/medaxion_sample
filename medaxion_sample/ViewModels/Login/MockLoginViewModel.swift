//
//  MockLoginViewModel.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

//TODO: Implement MockLoginViewModel for testing the LoginViewController

class MockLoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Properties
    var username: String?
    var password: String?
    
    // Simulated outcome of the login attempt.
    var loginShouldSucceed: Bool
    var loginWasCalled: Bool = false

    // MARK: - Lifecycle
    init(loginShouldSucceed: Bool) {
        self.loginShouldSucceed = loginShouldSucceed
    }
    
    // MARK: - Functions
    func login(completion: @escaping (Bool) -> Void) {
        loginWasCalled = true
        DispatchQueue.main.async {
            completion(self.loginShouldSucceed)
        }
    }
}

