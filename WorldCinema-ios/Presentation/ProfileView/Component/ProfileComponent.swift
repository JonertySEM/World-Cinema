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
    var logOutUseCase: LogOutUseCase { get }
    var uploadProfileDataUseCase: UploadProfileDataUseCase { get }
}


final class ProfileComponent: Component <ProfileComponentDependency> {
    
    var profileViewModel: ProfileViewModel {
        shared {
            ProfileViewModel(getProfileDataUseCase: dependency.getProfileDataUseCase,
                             getTokensUseCase: dependency.getTokensUseCase, logOutUseCase: dependency.logOutUseCase,
                             uploadProfileDataUseCase: dependency.uploadProfileDataUseCase)
        }
    }
    
    var profileViewController: ProfileViewController {
        return ProfileViewController(viewModel: profileViewModel)
    }
}
