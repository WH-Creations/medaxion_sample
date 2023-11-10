//
//  HomeViewModel.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation
import Foundation

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Properties
    var characterList: [MarvelCharacter] = []
    var isLoading: Bool = false
    private var marvelApiService: MarvelApiServiceProtocol
    
    // MARK: - Initialization
    init(marvelApiService: MarvelApiServiceProtocol) {
        self.marvelApiService = marvelApiService
    }
    
    // MARK: - Data Loading
    func loadCharacterList(offset: Int, completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        guard !isLoading else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Already loading"])))
            return
        }
        isLoading = true

        marvelApiService.getMarvelCharacters(offset: offset) { [weak self] (result) in
            self?.isLoading = false
            
            switch result {
            case .success(let characters):
                if offset == 0 {
                    // Reset the list if it's a fresh load
                    self?.characterList = characters
                } else {
                    // Append to the list if it's pagination
                    self?.characterList.append(contentsOf: characters)
                }
                completion(.success(self?.characterList ?? []))
            case .failure(let error):
                // Handle error, e.g. by storing it in a property to show an alert
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Refresh Control
    func refreshCharacterList(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        loadCharacterList(offset: 0) { result in
            switch result {
            case .success(let characters):
                // Reset the list with the new characters
                self.characterList = characters
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


