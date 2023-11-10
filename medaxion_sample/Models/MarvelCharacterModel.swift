//
//  MarvelCharacterModel.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import Foundation

/**
 - Use decodables for all JSON parsing
 */

struct MarvelCharacter: Decodable, Equatable {
    let id: Int
    let name: String?
    let description: String?
    let resourceURI: String?
    let thumbnail: MarvelCharacterThumbnail?
    let comics: MarvelCharacterDetails?
    let stories: MarvelCharacterDetails?
    let events: MarvelCharacterDetails?
    let series: MarvelCharacterDetails?

    // Implement the Equatable protocol
    static func ==(lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MarvelCharacterDetails: Decodable {
    let available: Int
    let items: [MarvelCharacterDetailItem]?
    let returned: Int
}

struct MarvelCharacterDetailItem: Decodable {
    let name: String?
}

struct MarvelCharacterThumbnail: Decodable, Equatable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case ext = "extension"
        case path
    }
}

/**
 - Used to group CharacterDetailItems into appropriate sections in the CharacterDetailViewController tableView
 */
struct GroupedCategory {
    let name : String
    var items : [MarvelCharacterDetailItem]
}
