//
//  MockAuthenticationService.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

class MockAuthenticationService: AuthenticationServiceProtocol {
    var shouldReturnSuccess: Bool
    var receivedUsername: String?
    var receivedPassword: String?
    
    init(shouldReturnSuccess: Bool) {
        self.shouldReturnSuccess = shouldReturnSuccess
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // Store the received credentials to allow for assertion in tests
        receivedUsername = username
        receivedPassword = password
        
        // Return the pre-determined success or failure result
        completion(shouldReturnSuccess)
    }
}
