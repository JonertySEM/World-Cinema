//
//  RegistrationComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 26.03.2023.
//

import Foundation
import NeedleFoundation
import UIKit

protocol RegistrationComponentDependency: Dependency {
    var registrationUseCase: RegistrationUseCase { get }
}

final class RegistrationComponent: Component<RegistrationComponentDependency> {
    var registrationViewModel: RegistrationViewModel {
        shared {
            RegistrationViewModel(registrationUseCase: dependency.registrationUseCase)
        }
    }

    var registrationViewController: UIViewController {
        return RegistrationViewController(viewModel: registrationViewModel)
    }
}
