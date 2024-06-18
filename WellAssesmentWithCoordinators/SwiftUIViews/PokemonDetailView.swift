//
//  PokemonDetailView.swift
//  WellPokemonAssesment
//
//  Created by Derrick Wilde on 5/29/24.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemonData: PokemonData
    init(pokemonData:PokemonData) {
        self.pokemonData = pokemonData
    }
    var body: some View {
        ZStack {
            
            VStack {
                AsyncImage(url: pokemonData.imageUrl)
                Text(pokemonData.description)
            }
            .navigationTitle(pokemonData.name)
            .toolbarBackground(Color.navBarBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            
            Text("SwiftUI")
                .opacity(0.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topLeading)
        }
    }
}
//todo
//#Preview {
//    PokemonDetailView()
//}
