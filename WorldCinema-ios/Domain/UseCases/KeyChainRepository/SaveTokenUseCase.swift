//
//  SaveTokenUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation
import NeedleFoundation

protocol SaveTokensUseCaseDependency: Dependency {
    var saveTokenUseCaseProvider: SaveTokensUseCase { get }
}

class SaveTokensUseCase {
    private let keychainRepository: KeychainRepository

    init(keychainRepository: KeychainRepository) {
        self.keychainRepository = keychainRepository
    }

    func execute(
        authToken: String?,
        refreshToken: String?,
        completion: ((Result<Void, Error>) -> Void)? = nil
    ) {
        if let authToken = authToken {
            keychainRepository.saveValueByKey(
                KeyChainTokenTypesEnum.auth.rawValue,
                value: authToken,
                completion: refreshToken != nil ? nil : completion
            )
        }

        if let refreshToken = refreshToken {
            keychainRepository.saveValueByKey(
                KeyChainTokenTypesEnum.refresh.rawValue,
                value: refreshToken,
                completion: completion
            )
        }
    }
}
