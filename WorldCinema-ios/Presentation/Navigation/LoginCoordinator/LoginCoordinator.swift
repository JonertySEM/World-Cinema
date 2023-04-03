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
        
        controller.completionHandler = { [weak self] _ in
            self?.showRegistrationModule()
        }
        
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func showRegistrationModule() {
        let controller = moduleFactory.createRegistrationModule()
        navigationController.present(controller, animated: true)
    }
    
}
    

