//
//  MainComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 24.03.2023.
//

import Foundation
import NeedleFoundation
import UIKit

final class MainComponent: BootstrapComponent {
    
    var jsonDecoder: JSONDecoder {
        shared {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return decoder
        }
    }

    var jsonEncoder: JSONEncoder {
        shared {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601

            return encoder
        }
    }
    
    var authRepository: AuthorizationRepository {
        shared {
            AuthRepositoryImpl(jsonDecoder: jsonDecoder,
                               jsonEncoder: jsonEncoder)
        }
    }

    
    var loginUseCase: LoginUseCase {
        shared {
            LoginUseCase(authRepository: authRepository)
        }
    }
    
    
    var authorizationComponent: AuthorizationComponent {
        shared {
            AuthorizationComponent(parent: self)
        }
    }

    var registrationComponent: RegistrationComponent {
        shared {
            RegistrationComponent(parent: self)
        }
    }


    var mainViewController: UIViewController {
        return MainViewController()
    }
}
