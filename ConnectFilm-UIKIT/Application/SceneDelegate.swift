//
//  SceneDelegate.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 02/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: RootCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        /// Coordinator Setup

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = RootCoordinator(window: newWindow)

        newWindow.windowScene = windowScene
        coordinator.presentMainScreen()

        window = newWindow
        self.coordinator = coordinator
    }
}
