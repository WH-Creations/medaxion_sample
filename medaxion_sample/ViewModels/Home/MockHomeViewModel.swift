//
//  MockHomeViewModel.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

class MockHomeViewModel: HomeViewModelProtocol {
    var characterList: [MarvelCharacter]
    var isLoading: Bool = false

    init(characters: [MarvelCharacter]) {
        self.characterList = characters
    }

    func loadCharacterList(offset: Int, completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        completion(.success(characterList))
    }

    func refreshCharacterList(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        completion(.success(characterList))
    }
}
