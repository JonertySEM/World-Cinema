//
//  UploadProfileDataUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 11.04.2023.
//

import Foundation
import NeedleFoundation


protocol UploadProfileDataUseCaseDependency: Dependency {
    var uploadProfileDataUseCase: UploadProfileDataUseCase { get }
}

class UploadProfileDataUseCase{
    private let profileRepository: ProfileRepository
    
    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }
    
    func execute(token: String,
                 imageData: Data?,
                 completion: ((Result<VoidResponse, Error>) -> Void)? = nil) {
        profileRepository.uploadAvatarPhoto(token: token,
                                            imageData: imageData,
                                            completion: completion)
    }
}
