//
//  SceneDelegate.swift
//  WellAssesmentWithCoordinators
//
//  Created by Derrick Wilde on 6/17/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: WellAppCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let appCoordinator = WellAppCoordinator(window: window)
            appCoordinator.start()
            self.appCoordinator = appCoordinator
            window.makeKeyAndVisible()
        }
    }
}

