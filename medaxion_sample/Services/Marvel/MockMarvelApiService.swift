//
//  MockMarvelApiService.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

class MockMarvelApiService: MarvelApiServiceProtocol {

    //One important distinction would be where we want to pull this test data from. I will commonly put this sample data directly in the project in a json file. We could also test the json deserialization if we were to go that route. Which is good :)
    var mockCharacters: [MarvelCharacter] = [
            MarvelCharacter(
                id: 1,
                name: "Iron Man",
                description: "A wealthy industrialist and genius inventor",
                resourceURI: nil,
                thumbnail: MarvelCharacterThumbnail(path: "path/to/ironman", ext: "jpg"),
                comics: nil,
                stories: nil,
                events: nil,
                series: nil
            ),
            MarvelCharacter(
                id: 2,
                name: "Hulk",
                description: "A green behemoth",
                resourceURI: nil,
                thumbnail: MarvelCharacterThumbnail(path: "path/to/hulk", ext: "jpg"),
                comics: nil,
                stories: nil,
                events: nil,
                series: nil
            )
        ]
    
    var shouldReturnError = false
    var error: Error?

    func getMarvelCharacters(offset: Int, completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(error ?? NSError(domain: "MockError", code: -1, userInfo: nil)))
        } else {
            completion(.success(mockCharacters))
        }
    }
}

