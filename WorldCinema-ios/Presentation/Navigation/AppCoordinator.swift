//
//  AppCoordinator.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import SwiftyUserDefaults
import UIKit

class AppCoordinator: CoordinatorMainRepository {
    var navigationController: UINavigationController
    private var authStatusObserver: DefaultsDisposable?
    
    private var getAuthStatusUseCase = GetAuthStatusUseCase()
    
    private var childCoordinators: [CoordinatorMainRepository] = []
    
    var flowCompletionHendler: CoordinatorHendler?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        getAuthStatus()
        observeAuthStatus()
    }
    
    private func getAuthStatus() {
        getAuthStatusUseCase.execute { [weak self] result in
            
            switch result {
                case .success(let isAuthorized):
                    self?.changeViewWithAuthStatus(authStatus: isAuthorized)
                   
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func changeViewWithAuthStatus(authStatus: Bool) {
        if authStatus {
            print("user is authorized isAuthorized = \(authStatus)")
            showHomeFlow()
        } else {
            print("user is not authorized")
            showLoginFlow()
        }
    }
    
    private func observeAuthStatus() {
        authStatusObserver = Defaults.observe(\.isAuthorized) { [self] update in
            if let isAuthorized = update.newValue,
               let isAuthorizedUnwrapped = isAuthorized
            {
                changeViewWithAuthStatus(authStatus: isAuthorizedUnwrapped)
            }
        }
    }
    
    private func showLoginFlow() {
        let authCoordinator = CoordinatorFactory().createAuthorizationCoordinator(navigationController: navigationController)
        
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    private func showHomeFlow() {
        let homeCoordinator = CoordinatorFactory().createHomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
