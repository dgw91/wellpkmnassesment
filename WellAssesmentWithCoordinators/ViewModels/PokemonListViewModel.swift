//
//  PokemonListViewModel.swift
//  WellPokemonAssesment
//
//  Created by Derrick Wilde on 5/29/24.
//

import Foundation
import Combine

class PokemonListViewModel {
    let api = NetworkingBase()
    public var pokemonList: [PokemonData] = []
    func loadPokemonData() async {
        //TODO implment prioper throwing error handling based on enum
        guard let url = api.baseUrl else {
            print ("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let pokemonData = try JSONDecoder().decode([PokemonData].self, from: data)
            self.pokemonList = pokemonData
        } catch {
            print("invalid data")
        }
    }
}
