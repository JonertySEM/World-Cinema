//
//  AppCoordinator.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import SwiftyUserDefaults
import UIKit

class AppCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    private var authMode = ScreenModelTypeEnums.authType
    
    var navigationController: UINavigationController
    private var authStatusObserver: DefaultsDisposable?
    
    private var getAuthStatusUseCase = GetAuthStatusUseCase()
    
    var childCoordinators = [Coordinator]()
    
    var flowCompletionHendler: CoordinatorHendler?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
        
        getAuthStatus()
        
        observeAuthStatus()
    }
    
    func start() {
        switch authMode {
        case .authType:
            showLoginFlow()
        case .homeType:
            showHomeFlow()
        }
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
            authMode = .homeType
        } else {
            print("user is not authorized")
            authMode = .authType
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
        authCoordinator.finishDelegate = self
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    private func showHomeFlow() {
        let homeCoordinator = CoordinatorFactory().createHomeCoordinator(navigationController: navigationController)
        homeCoordinator.finishDelegate = self
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {}
}
