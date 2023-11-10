//
//  MarvelServiceProtocol.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

protocol MarvelApiServiceProtocol {
    /// Fetches a list of Marvel characters starting from a specified offset.
    ///
    /// - Parameters:
    ///   - offset: The starting position for fetching characters. Used for pagination.
    ///   - completion: A closure that is called with the result of the fetch operation.
    ///                The result contains an array of `MarvelCharacter` on success or an `Error` on failure.
    func getMarvelCharacters(offset: Int, completion: @escaping (Result<[MarvelCharacter], Error>) -> Void)
}
