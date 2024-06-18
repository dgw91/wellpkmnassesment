//
//  PokemonListView.swift
//  WellPokemonAssesment
//
//  Created by Derrick Wilde on 5/29/24.
//

import SwiftUI

struct PokemonListView: View {
    
    var pokemonListVM: PokemonListViewModel
    var switchToUIKit: () -> () = { }
    
    @State private var pkmnList = [PokemonData]()
    var body: some View {
        NavigationStack {
            ZStack {
                List(pkmnList, id: \.id) { pkmn in
                    NavigationLink(destination: PokemonDetailView(pokemonData: pkmn)) {
                        PokemonListViewCell(pokemonData: pkmn)
                    }
                }
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .listStyle(.plain)
                .listRowSeparator(.hidden, edges: .all)
                .task {
                    await pokemonListVM.loadPokemonData()
                    pkmnList = pokemonListVM.pokemonList
                }
                VStack {
                    Text("SwiftUI")
                        .opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topLeading)
                    Button("Switch To UIKit") {
                        switchToUIKit()
                    }
                    .buttonStyle(.bordered)
                    .opacity(0.8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.topTrailing)
                    .padding()
                }
            }
            .navigationTitle("Pokémon")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.pokeNavBarTint, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .tint(.pokeToolBarTint)
        .ignoresSafeArea(.all)
        .backgroundStyle(.white)
    }
}
