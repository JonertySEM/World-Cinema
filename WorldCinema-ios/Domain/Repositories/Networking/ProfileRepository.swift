//
//  ProfileRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 09.04.2023.
//

import Foundation

protocol ProfileRepository {
    func getProfileData(
        token: String,
        completion: ((Result<ProfileResponse, Error>) -> Void)?
    )

    func uploadAvatarPhoto(
        token: String,
        imageData: Data?,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
}
