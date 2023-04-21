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
    private let createCollectionUseCase: CreateCollectionUseCase

    init(
        authorizationRepository: AuthorizationRepository,
        saveTokensUseCase: SaveTokensUseCase,
        saveAuthStatusUseCase: SaveAuthStatusUseCase,
        createCollectionUseCase: CreateCollectionUseCase
    ) {
        self.authorizationRepository = authorizationRepository
        self.saveTokensUseCase = saveTokensUseCase
        self.saveAuthStatusUseCase = saveAuthStatusUseCase
        self.createCollectionUseCase = createCollectionUseCase
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
                                                                 self?.createCollectionUseCase.execute(token: loginResponse.accessToken, name: "Избранное")
                                                                 self?.saveAuthStatusUseCase.execute(isAuthorized: true)
                                                             }
                                                         }
                                                     )
                                                 }
                                             })
    }
}
