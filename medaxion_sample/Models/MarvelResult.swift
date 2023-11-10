//
//  MarvelResult.swift
//  medaxion_sample
//
//  Created by Casey West on 11/10/23.
//
import Foundation

/**
 - Use decodables for all JSON parsing
 */

struct MarvelResult: Decodable {
    let code: Int
    let status: String?
    let data: MarvelData
}

struct MarvelData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelCharacter]
}
