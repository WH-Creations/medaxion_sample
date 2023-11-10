//
//  LoginViewModel.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

/// ViewModel responsible for handling the login logic in a MVVM architecture.
class LoginViewModel: LoginViewModelProtocol {
    
    // MARK: - Properties
    var username: String?
    var password: String?
    private var authService: AuthenticationServiceProtocol
    
    // MARK: - Lifecycle
    /// Initializes the LoginViewModel with an authentication service.
    /// - Parameter authService: An object conforming to AuthenticationServiceProtocol.
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Functions
    /// Initiates the login process using the current username and password properties.
    /// - Parameter completion: A closure that is called with a Bool indicating whether the login was successful.
    func login(completion: @escaping (Bool) -> Void) {
        // Ensure that both username and password are not nil before proceeding.
        guard let username = username, let password = password else {
            completion(false) // Credentials are not available, can't login
            return
        }
        
        // Call the login method on the authentication service, passing the credentials and the completion handler.
        authService.login(username: username, password: password) { success in
            completion(success)
        }
    }
}
