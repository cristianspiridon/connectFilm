//
//  RootCoordinator.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 02/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation
import UIKit

// This class is responsible for the application flow.

final class RootCoordinator {
    weak var window: UIWindow!

    init(window: UIWindow) {
        self.window = window
    }

    /// Presents the tab bar
    func presentMainScreen() {
        guard let window = window else { return }
        window.rootViewController = makeTabBarViewController()
        window.makeKeyAndVisible()
    }

    /// Makes a tab bar with the  movies and the profile screen
    ///
    /// - Returns: tab bar as a UIViewController
    private func makeTabBarViewController() -> UIViewController {
        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [makeMoviesScreen(), makeFavouriteScreen()]

        return tabBarViewController
    }

    private func makeMoviesScreen() -> UIViewController {
        let moviesViewController: MoviesViewController = {
            let vc = MoviesViewController.instantiate()
            vc.title = "Popular Movies"
            vc.tabBarItem.image = UIImage(named: "Movies-Outlined")
            return vc
        }()

        let dataSource = MoviesDataSource(network: Network(), persistence: RealmService.shared)
        let model = MoviesListViewModel(dataStore: dataSource)
        moviesViewController.viewModel = model

        // Setup on select movie callback
        let navigation = moviesViewController.wrappedInNavigationController()
        let detailsScreen = MovieDetailsViewController.instantiate()

        model.onSelectMovie = { [weak navigation] movie in
            detailsScreen.model = movie
            detailsScreen.dataStore = dataSource
            navigation?.pushViewController(detailsScreen, animated: true)
        }

        return navigation
    }

    private func makeFavouriteScreen() -> UIViewController {
        let favouriteViewController: FavouriteMoviesViewController = {
            let vc = FavouriteMoviesViewController.instantiate()
            vc.title = "Favourites"
            vc.tabBarItem.image = UIImage(named: "Profile-Outlined")
            return vc
        }()

        let navigation = favouriteViewController.wrappedInNavigationController()

        let dataSource = MoviesDataSource(network: Network(), persistence: RealmService.shared)
        let model = FavouriteMoviesViewModel(dataStore: dataSource)
        favouriteViewController.model = model

        return navigation
    }
}

private extension UIViewController {
    /// Wraps the view controller in navigation controller and
    /// copies the title and tab bar item
    ///
    /// - Returns: UINavigationController
    func wrappedInNavigationController() -> UINavigationController {
        let nc = UINavigationController(rootViewController: self)
        nc.title = title
        nc.tabBarItem = tabBarItem
        return nc
    }
}
