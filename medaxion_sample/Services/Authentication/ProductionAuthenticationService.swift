//
//  ProductionAuthenticationService.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

class ProductionAuthenticationService: AuthenticationServiceProtocol {
    
    // MARK: - Functions
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // Implementation of login using username and password
        // This could involve making a network request and validating the response
        // For now, let's simulate an async network call with a delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let isSuccess = true // Assume the credentials are correct
            completion(isSuccess)
        }
    }
    
}
