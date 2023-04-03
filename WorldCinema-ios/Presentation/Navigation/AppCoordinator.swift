//
//  AppCoordinator.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorMainRepository {
    var navigationController: UINavigationController
    
    private var childCoordinators: [CoordinatorMainRepository] = []
    
    var flowCompletionHendler: CoordinatorHendler?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        // Check Login/Register user or not
        
        showLoginFlow()
    }
    
    private func showLoginFlow() {
        let authCoordinator = CoordinatorFactory().createAuthorizationCoordinator(navigationController: navigationController)
        
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
}
