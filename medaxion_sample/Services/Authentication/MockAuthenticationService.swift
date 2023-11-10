//
//  MockAuthenticationService.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

class MockAuthenticationService: AuthenticationServiceProtocol {
    var shouldReturnSuccess: Bool

    init(shouldReturnSuccess: Bool) {
        self.shouldReturnSuccess = shouldReturnSuccess
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        
        // Return the pre-determined success or failure result
        completion(shouldReturnSuccess)
    }
}
