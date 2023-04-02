//
//  AuthorizationComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 24.03.2023.
//

import Foundation
import NeedleFoundation
import UIKit

protocol AuthorizationComponentDependency: Dependency {
    var loginUseCase: LoginUseCase { get }
}

final class AuthorizationComponent: Component<AuthorizationComponentDependency> {
    var authorizationViewModel: AuthorizationViewModel {
        shared {
            AuthorizationViewModel(loginUseCase: dependency.loginUseCase)
        }
    }
    
    var authorizationViewController: UIViewController {
        return AuthorizationViewController(viewModel: authorizationViewModel)
    }
}
