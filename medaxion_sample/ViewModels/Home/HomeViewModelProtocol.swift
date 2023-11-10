//
//  HomeViewModelProtocol.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

protocol HomeViewModelProtocol {
    var characterList: [MarvelCharacter] { get }
    var isLoading: Bool { get set }
    func loadCharacterList(offset: Int, completion: @escaping (Result<[MarvelCharacter], Error>) -> Void)
    func refreshCharacterList(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void)
}
