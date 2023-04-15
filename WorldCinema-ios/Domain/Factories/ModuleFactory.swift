//
//  ModuleFactory.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation

class ModuleFactory {
    
    private var mainComponent = MainComponent()
    func getAuthorizationComponent() -> AuthorizationComponent {
        mainComponent.authorizationComponent
    }
    
    func createRegistrationModule() -> RegistrationComponent {
        mainComponent.registrationComponent
    }
    
    func createHomeModule() -> HomeComponent {
        mainComponent.homeComponent
    }
    
    func createCompilationModule() -> CompilationComponent {
        mainComponent.compilationComponent
    }
    
    func createColectionModule() -> CollectionComponent {
        mainComponent.collectionComponent
    }
    
    func createProfileModule() -> ProfileComponent {
        mainComponent.profileComponent
    }
    
    func createMovieModule() -> MovieComponent {
        mainComponent.movieComponent
    }
}
