//
//  RegisrationUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 02.04.2023.
//

import Foundation
import NeedleFoundation

protocol RegisrationUseCaseProvider: Dependency {
    var regisrationUseCaseProvider: RegistrationUseCase { get }
}

class RegistrationUseCase {
    private let authorizationRepository: AuthorizationRepository
    private let saveTokensUseCase: SaveTokensUseCase
    private let saveAuthStatusUseCase: SaveAuthStatusUseCase

    init(
        authorizationRepository: AuthorizationRepository,
        saveTokensUseCase: SaveTokensUseCase,
        saveAuthStatusUseCase: SaveAuthStatusUseCase
    ) {
        self.authorizationRepository = authorizationRepository
        self.saveTokensUseCase = saveTokensUseCase
        self.saveAuthStatusUseCase = saveAuthStatusUseCase
    }

    func execute(
        request: RegistrationRequest,
        completion: ((Result<AuthResponse, Error>) -> Void)? = nil
    ) {
        authorizationRepository.registration(registrationRequest: request,
                                             completion: { [weak self] result in
                                                 completion?(result)

                                                 if case .success(let loginResponse) = result {
                                                     self?.saveTokensUseCase.execute(
                                                         authToken: loginResponse.accessToken,
                                                         refreshToken: loginResponse.refreshToken,
                                                         completion: { [weak self] result in
                                                             if case .success = result {
                                                                 self?.saveAuthStatusUseCase.execute(isAuthorized: true)
                                                             }
                                                         }
                                                     )
                                                 }
                                             })
    }
}
