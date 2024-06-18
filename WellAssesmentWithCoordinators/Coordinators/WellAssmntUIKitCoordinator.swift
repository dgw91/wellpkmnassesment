//
//  WellAssmntUIKitCoordinator.swift
//  WellAssesmentWithCoordinators
//
//  Created by Derrick Wilde on 6/18/24.
//

import Foundation
import SwiftUI
import UIKit
import Combine

class WellAssmntUIKitCoordinator: Coordinator {
    var tag = ViewBuilderType.UIKit.rawValue
    let viewInUIKit: CurrentValueSubject<Bool, Never>
    var cancellables = Set<AnyCancellable>()
    let vm = PokemonListViewModel()
    var rootViewController = UIViewController()
    init(viewInUIKit: CurrentValueSubject<Bool, Never>) {
        self.viewInUIKit = viewInUIKit
    }
    
    func start() {
        let vc = PokemonListUIView(vm: vm)
        vc.showInSwiftUI = self.switchToSWUI
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.backgroundColor = UIColor(Color.pokeNavBarTint)
        navController.title = "Pokémon"
        self.rootViewController = navController
        
        viewInUIKit
            .sink { value in
                if value == false {
                    self.switchToSWUI()
                }
            }
            .store(in: &cancellables)
    }
    
    func switchToSWUI() {
        let vc = PokemonListView(pokemonListVM: vm)
        self.rootViewController = UIHostingController(rootView: vc)
        if self.viewInUIKit.value != false {
            self.viewInUIKit.send(false)
        }
    }
}
