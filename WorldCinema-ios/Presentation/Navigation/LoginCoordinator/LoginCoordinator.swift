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
        let component = moduleFactory.getAuthorizationComponent()
        
        component.authorizationViewModel.completionHandler = { [weak self] _ in
            self?.finish()
            self?.showHomeMovieModule()
        }
        
        component.authorizationViewModel.completionHandlerButton = { [weak self] _ in
            self?.showRegistrationModule()
        }
        
        navigationController.pushViewController(component.authorizationViewController, animated: true)
    }
    
    private func showHomeMovieModule() {
        let homeCoordinator = CoordinatorFactory().createHomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
    
    private func showRegistrationModule() {
        let component = moduleFactory.createRegistrationModule()
        
        component.registrationViewModel.completionHandler = { [weak self] _ in
            self?.finish()
            self?.showHomeMovieModule()
        }
        
        component.registrationViewModel.completionHandlerButton = { [weak self] _ in
            self?.showAuthModule()
        }
        
        navigationController.pushViewController(component.registrationViewController, animated: true)
    }
}
    
