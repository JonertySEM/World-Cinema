//
//  LoginComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 27.03.2023.
//

import Foundation
import NeedleFoundation
import UIKit

protocol LoginComponentDependency: Dependency {}

final class LoginComponent: Component<LoginComponentDependency> {
    
    var loginViewModel: LoginViewModel {
        shared {
            LoginViewModel()
        }
    }
    
    var loginViewController: UIViewController {
        return LoginViewController()
    }
}
