//
//  LoginCoordinator.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import UIKit

class LoginCoordinator: CoordinatorMainRepository {
    var navigationController: UINavigationController
    
    var flowCompletionHendler: CoordinatorHendler?
    
    private let moduleFactory = ModuleFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAuthModule()
    }
    
    private func showAuthModule() {
        let controller = moduleFactory.createAuthModule()
        
        controller.viewModel.completionHandler = { [weak self] _ in
            self?.showHomeMovieModule()
        }
        
        controller.viewModel.completionHandlerButton = { [weak self] _ in
            self?.showRegistrationModule()
        }
        
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func showHomeMovieModule() {
        let controller = moduleFactory.createHomeModule()
        
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func showRegistrationModule() {
        let controller = moduleFactory.createRegistrationModule()
        
        controller.viewModel.completionHandler = { [weak self] _ in
            self?.showHomeMovieModule()
        }
        
        controller.viewModel.completionHandlerButton = { [weak self] _ in
            self?.showAuthModule()
        }
        
        navigationController.pushViewController(controller, animated: true)
    }
}
    
