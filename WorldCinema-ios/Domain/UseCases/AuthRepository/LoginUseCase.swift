//
//  LoginUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 29.03.2023.
//

import Foundation
import NeedleFoundation

protocol LoginUseCaseDependency: Dependency {
    var loginUseCaseProvider: LoginUseCase { get }
}

class LoginUseCase {
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
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<AuthResponse, Error>) -> Void)? = nil
    ) {
        authorizationRepository.login(
            authorizationRequest: authorizationRequest,
            completion: { [weak self] result in
                completion?(result)

                if case .success(let loginResponse) = result {
                    print("--------------TOKENS")
                    print(loginResponse.accessToken)
                    print(loginResponse.refreshToken)
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
            }
        )
    }
}
