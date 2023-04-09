//
//  GetProfileDataUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 09.04.2023.
//

import Foundation
import NeedleFoundation


protocol GetProfileDataUseCaseDependency: Dependency {
    var getProfileDataUseCase: GetProfileDataUseCase { get }
}

class GetProfileDataUseCase{
    private let profileRepository: ProfileRepository
    
    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    func execute(token: String,
                 completion: ((Result<ProfileResponse, Error>) -> Void)? = nil) {
        profileRepository.getProfileData(token: token, completion: completion)
    }
}
