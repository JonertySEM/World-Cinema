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
    
    func createHomeModule() -> HomeViewController {
        MainComponent().homeComponent.homeViewController as! HomeViewController
    }
    
    func createCompilationModule() -> CompilationViewController {
        MainComponent().compilationComponent.compilationViewController
    }
    
    func createColectionModule() -> CollectionViewController {
        MainComponent().collectionComponent.collectionViewController
    }
    
    func createProfileModule() -> ProfileViewController {
        MainComponent().profileComponent.profileViewController
    }
}
