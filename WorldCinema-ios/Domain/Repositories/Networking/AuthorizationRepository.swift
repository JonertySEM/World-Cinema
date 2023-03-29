//
//  AuthorizationRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 28.03.2023.
//

import Foundation

protocol AuthorizationRepository {
    func login(
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<AuthResponse, Error>) -> Void)?
    )

    func registration(
        registrationRequest: RegistrationRequest,
        completion: ((Result<AuthResponse, Error>) -> Void)?
    )

    func updateRefreshToken(
        authorizationRequest: RefreshTokenRequest,
        completion: ((Result<AuthResponse, Error>) -> Void)?
    )
}
