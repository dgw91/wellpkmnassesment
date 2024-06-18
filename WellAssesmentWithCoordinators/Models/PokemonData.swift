//
//  PokemonData.swift
//  WellPokemonAssesment
//
//  Created by Derrick Wilde on 5/29/24.
//

import Foundation

public struct PokemonData: Codable, Sendable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: URL
}
