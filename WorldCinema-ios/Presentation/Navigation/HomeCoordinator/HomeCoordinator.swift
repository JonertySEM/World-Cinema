//
//  HomeCoordinator.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation
import UIKit

class HomeCoordinator: CoordinatorMainRepository {
    var navigationController: UINavigationController
    
    var flowCompletionHendler: CoordinatorHendler?
    
    private let moduleFactory = ModuleFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeMovieModule()
    }
    
    private func showHomeMovieModule() {
        let controller = moduleFactory.createHomeModule()
        
        navigationController.pushViewController(controller, animated: true)
    }
}
