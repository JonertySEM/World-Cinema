//
//  RegistrationComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 26.03.2023.
//

import Foundation
import NeedleFoundation
import UIKit

protocol RegistrationComponentDependency: Dependency {}

final class RegistrationComponent: Component<RegistrationComponentDependency> {
    var registrationViewModel: RegistrationViewModel {
        shared {
            RegistrationViewModel()
        }
    }

    var registrationViewController: UIViewController {
        return RegistrationViewController()
    }
}
