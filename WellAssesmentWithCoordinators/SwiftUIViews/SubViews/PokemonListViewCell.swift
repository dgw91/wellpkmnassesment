//
//  ListViewCell.swift
//  WellPokemonAssesment
//
//  Created by Derrick Wilde on 5/29/24.
//

import SwiftUI

struct PokemonListViewCell: View {
    
    private var pokemonData: PokemonData
    
    init(pokemonData: PokemonData) {
        self.pokemonData = pokemonData
    }
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: pokemonData.imageUrl)
                .frame(width: 40, height: 40)
            VStack(spacing: 5) {
                Text(pokemonData.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                Text(pokemonData.description)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
//TODO add sample data to display here
//#Preview {
//    PokemonListViewCell()
//}
