//
//  ModuleFactory.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation

class ModuleFactory {
    
    func createAuthModule() -> AuthorizationViewController {
        MainComponent().authorizationComponent.authorizationViewController as! AuthorizationViewController
    }
    
    func createRegistrationModule() -> RegistrationViewController {
        MainComponent().registrationComponent.registrationViewController as! RegistrationViewController
    }
}
