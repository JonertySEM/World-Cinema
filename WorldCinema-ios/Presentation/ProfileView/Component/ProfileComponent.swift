//
//  ProfileComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import Foundation
import NeedleFoundation

protocol ProfileComponentDependency: Dependency {
    var getProfileDataUseCase: GetProfileDataUseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }
}


final class ProfileComponent: Component <ProfileComponentDependency> {
    
    var profileViewModel: ProfileViewModel {
        shared {
            ProfileViewModel(getProfileDataUseCase: dependency.getProfileDataUseCase,
                             getTokensUseCase: dependency.getTokensUseCase)
        }
    }
    
    var profileViewController: ProfileViewController {
        return ProfileViewController(viewModel: profileViewModel)
    }
}