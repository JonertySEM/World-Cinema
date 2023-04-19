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
    
    var filmData = MovieResponse()
    
    private let moduleFactory = ModuleFactory()
    
    required init(_ navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController = navigationController
    }
    
    func start() {
        showMovieModule(film: filmData)
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
        
        component.movieViewModel.completionHandlerButton = { [weak self] episode in
            guard let seria = episode else { return }
            
            self?.showEpisodeModule(episode: seria, film: film)
           
        }
        
        navigationController.pushViewController(component.movieViewController, animated: true)
    }
    
    private func showEpisodeModule(episode: EpisodesResponse, film: MovieResponse) {
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
                    
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        let component = moduleFactory.createEpisodeModule()
        
        component.episodeViewModel.episode = episode
        component.episodeViewModel.film = film
        //component.episodeViewModel.countEpisode = episodesList.count
        
        navigationController.pushViewController(component.episodeViewController, animated: true)
    }
}
