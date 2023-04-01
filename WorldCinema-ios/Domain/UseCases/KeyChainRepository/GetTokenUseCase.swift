//
//  GetTokenUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetTokensUseCaseDependency: Dependency {
    var getTokensUseCaseProvider: GetTokensUseCase { get }
}

class GetTokensUseCase {
    private let keychainRepository: KeychainRepository

    init(keychainRepository: KeychainRepository) {
        self.keychainRepository = keychainRepository
    }

    func execute(tokenType: KeyChainTokenTypesEnum, completion: ((Result<String, Error>) -> Void)? = nil) {
        keychainRepository.getValueByKey(tokenType.rawValue, completion: completion)
    }
}
