//
//  AuthenticationServiceProtocol.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

protocol AuthenticationServiceProtocol {
    
    /// Attempts to log in with a given username and password.
    ///
    /// - Parameters:
    ///   - username: The username of the user attempting to log in.
    ///   - password: The password of the user attempting to log in.
    ///   - completion: A closure that is called with a Boolean value indicating whether the login was successful.
    func login(username: String, password: String, completion: @escaping (Bool) -> Void)
}
