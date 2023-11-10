//
//  LoginViewModelProtocol.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

protocol LoginViewModelProtocol {
    var username: String? { get set }
    var password: String? { get set }
    func login(completion: @escaping (Bool) -> Void)
}
