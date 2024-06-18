//
//  WellAppCoordinator.swift
//  WellAssesmentWithCoordinators
//
//  Created by Derrick Wilde on 6/18/24.
//

import SwiftUI
import UIKit
import Combine

class WellAppCoordinator: Coordinator {
    var tag = "AppCoordinator"
    let window: UIWindow
    var childCoordinators = [Coordinator]()
    let viewInUIKit = CurrentValueSubject<Bool, Never>(false)
    var cancellables = Set<AnyCancellable>()

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        viewInUIKit
            .sink { [weak self] useUIKit in
            if !useUIKit {
                if !(self?.childCoordinators.contains(where: { $0.tag == ViewBuilderType.swiftUI.rawValue }) ?? true) {
                    let swuiCoordinator = ListViewSWUICoordinator(switchToUIKit: self?.viewInUIKit ?? CurrentValueSubject<Bool, Never>(false))
                    swuiCoordinator.start()
                    self?.childCoordinators.append(swuiCoordinator)
                }
                if self?.window.rootViewController != nil{
                    self?.window.rootViewController = nil
                }
                let rootCoord = self?.childCoordinators.first(where: { $0.tag == ViewBuilderType.swiftUI.rawValue}) as? ListViewSWUICoordinator
                rootCoord?.start()
                self?.window.rootViewController = rootCoord?.rootViewController
            } else if let viewInUIKit = self?.viewInUIKit {
                if !(self?.childCoordinators.contains(where: {$0.tag == ViewBuilderType.UIKit.rawValue}) ?? true){
                    let uiKitCoordinator = WellAssmntUIKitCoordinator(viewInUIKit: viewInUIKit)
                    uiKitCoordinator.start()
                    self?.childCoordinators.append(uiKitCoordinator)
                }
                let rootCoord = self?.childCoordinators.first(where: { $0.tag == ViewBuilderType.UIKit.rawValue}) as? WellAssmntUIKitCoordinator
                rootCoord?.start()
                self?.window.rootViewController = rootCoord?.rootViewController
            }
        }
        .store(in: &cancellables)
    }
}
