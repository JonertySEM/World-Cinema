//
//  LoginCoordinator.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var flowCompletionHendler: CoordinatorHendler?
    
    private let moduleFactory = ModuleFactory()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAuthModule()
    }
    
    private func showAuthModule() {
        let controller = moduleFactory.createAuthModule()
        
        controller.viewModel.completionHandler = { [weak self] _ in
            self?.finish()
            self?.showHomeMovieModule()
        }
        
        controller.viewModel.completionHandlerButton = { [weak self] _ in
            self?.showRegistrationModule()
        }
        
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func showHomeMovieModule() {
        let homeCoordinator = CoordinatorFactory().createHomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
    
    private func showRegistrationModule() {
        let controller = moduleFactory.createRegistrationModule()
        
        controller.viewModel.completionHandler = { [weak self] _ in
            self?.finish()
            self?.showHomeMovieModule()
        }
        
        controller.viewModel.completionHandlerButton = { [weak self] _ in
            self?.showAuthModule()
        }
        
        navigationController.pushViewController(controller, animated: true)
    }
}
    
