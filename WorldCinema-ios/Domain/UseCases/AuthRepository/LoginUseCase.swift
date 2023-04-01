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
    private let authRepository: AuthorizationRepository

    init(authRepository: AuthorizationRepository) {
        self.authRepository = authRepository
    }

    func execute(
        authorizationRequest: AuthorizationRequest,
        completion: ((Result<AuthResponse, Error>) -> Void)? = nil
    ) {
        authRepository.login(
            authorizationRequest: authorizationRequest,
            completion: { [weak self] result in
                completion?(result)

                if case .success(let loginResponse) = result {}
            }
        )
    }
}
