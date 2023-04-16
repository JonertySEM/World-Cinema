//
//  MovieCoordinator.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 15.04.2023.
//

import Foundation
import UIKit


class MovieCoordinator: Coordinator {
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var flowCompletionHendler: CoordinatorHendler?
    
    var film = MovieResponse()
    
    private let moduleFactory = ModuleFactory()
    
    required init(_ navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController = navigationController
    }
    
    
    func start() {
        showMovieModule(film: film)
    }
    
    
    private func showMovieModule(film: MovieResponse) {
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
                    
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        let component = moduleFactory.createMovieModule()
        component.movieViewModel.getFilmData(filmData: film)
        navigationController.pushViewController(component.movieViewController, animated: true)
    }
    
    
    
}
