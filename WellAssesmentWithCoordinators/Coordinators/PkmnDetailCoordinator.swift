//
//  PkmnDetailCoordinator.swift
//  WellAssesmentWithCoordinators
//
//  Created by Derrick Wilde on 6/18/24.
//

import Foundation
import SwiftUI
import UIKit

class PkmnDetailCoordinator: Coordinator {
    var tag: ViewBuilderType
    
    
    init(pkmnData: PokemonData) {
        self.pkmnData = pkmnData
    }
    var rootViewController = UIViewController()
    var pkmnData: PokemonData
    
    lazy var pkmnDetailVC: PokemonDetailViewUIKit = {
        let vc = PokemonDetailViewUIKit()
        vc.pokemonDescription.text = pkmnData.description
        vc.pokemonImageView.loadFrom(url: pkmnData.imageUrl)
        return vc
    }()
    
    func start() {
        rootViewController = pkmnDetailVC
    }
}
