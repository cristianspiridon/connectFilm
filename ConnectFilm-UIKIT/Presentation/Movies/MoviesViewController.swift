//
//  MoviesViewController.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 02/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Combine
import Foundation
import UIKit

protocol MoviesViewControllerDisplayLogic: class {
    func reloadData()
    func setActivityIndicator(isVisible: Bool)
    func showError(error: String)
}

class MoviesViewController: UIViewController, Storyboarded, MoviesViewControllerDisplayLogic {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var viewModel: MoviesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        viewModel.viewController = self

        viewModel.loadNextPage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }

    // MARK: Display Logic

    func reloadData() {
        tableView.isHidden = viewModel.moviesCount == 0
        noDataLabel.isHidden = !tableView.isHidden
        tableView.reloadData()
        setActivityIndicator(isVisible: false)
    }

    func setActivityIndicator(isVisible: Bool) {
        activityIndicator.isHidden = !isVisible
    }

    func showError(error _: String) {
        // TODO: display an alert to the user with the error
        print("oops we have an error, let's display it")
    }
}

// MARK: TableView Data Source and Delegates

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.moviesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.model = viewModel.movie(at: indexPath.row)
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 250
    }

    func tableView(_: UITableView, willDisplay _: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.moviesCount - 1 {
            viewModel.loadNextPage()
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectMovie(at: indexPath.row)
    }
}
