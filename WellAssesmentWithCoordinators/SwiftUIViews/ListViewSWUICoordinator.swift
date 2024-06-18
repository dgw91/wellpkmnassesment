//
//  ListViewSWUICoordinator
//  WellAssesmentWithCoordinators
//
//  Created by Derrick Wilde on 6/18/24.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class ListViewSWUICoordinator: NSObject, Coordinator {
    
    var rootViewController = UIViewController()
    let vm = PokemonListViewModel()
    var switchToUIKit: CurrentValueSubject<Bool, Never>
    var childCoordinators = [Coordinator]()
    var cancellables = Set<AnyCancellable>()
    var tag = ViewBuilderType.swiftUI.rawValue
    
    init(switchToUIKit: CurrentValueSubject<Bool, Never>) {
        self.switchToUIKit = switchToUIKit
    }
    
    func viewInUIKit() {
        let vc = PokemonListUIView(vm: self.vm)
        let navController = UINavigationController(rootViewController: vc)
        self.rootViewController = navController
        if switchToUIKit.value != true {
            self.switchToUIKit.send(true)
        }
    }
    
    func start() {
        switchToUIKit
            .sink { switchToUIKit in
                if switchToUIKit {
                    self.viewInUIKit()
                }
            }
            .store(in: &cancellables)
        var view = PokemonListView(pokemonListVM: vm)
        view.switchToUIKit = self.viewInUIKit
        rootViewController = UIHostingController(rootView: view)
    }
}
