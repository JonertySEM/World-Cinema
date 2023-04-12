//
//  CoordinatorFactory.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import UIKit

class CoordinatorFactory {
    func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        AppCoordinator(navigationController)
    }
    
    func createAuthorizationCoordinator(navigationController: UINavigationController) -> LoginCoordinator {
        LoginCoordinator(navigationController)
    }
    
    func createHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator {
        HomeCoordinator(navigationController)
    }
}
