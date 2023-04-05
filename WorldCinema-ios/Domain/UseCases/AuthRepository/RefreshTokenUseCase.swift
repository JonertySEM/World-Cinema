//
//  RefreshTokenUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Foundation
import NeedleFoundation

protocol RefreshTokenUseCaseDependency: Dependency {
    var refreshTokenUseCaseProvider: RefreshTokenUseCase { get }
}

class RefreshTokenUseCase {
    private let authRepository: AuthorizationRepository

    init(authRepository: AuthorizationRepository) {
        self.authRepository = authRepository
    }

    func execute(
        refreshTokenRequest: RefreshTokenRequest,
        completion: ((Result<AuthResponse, Error>) -> Void)?
    ) {
        authRepository.updateRefreshToken(authorizationRequest: refreshTokenRequest, completion: completion)
    }
}
