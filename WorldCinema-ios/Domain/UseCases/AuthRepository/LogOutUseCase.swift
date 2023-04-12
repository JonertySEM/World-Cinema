//
//  LogOutUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Foundation
import NeedleFoundation
import SwiftyUserDefaults

protocol LogoutUseCaseDependency: Dependency {
    var logoutUseCaseProvider: LogOutUseCase { get }
}

class LogOutUseCase {
    private let saveTokensUseCase: SaveTokensUseCase

    init(
        saveTokensUseCase: SaveTokensUseCase
    ) {
        self.saveTokensUseCase = saveTokensUseCase
    }

    func execute(isAuthorized: Bool, completion: ((Result<Void, Error>) -> Void)? = nil) {
        Defaults[\.isAuthorized] = isAuthorized

        saveTokensUseCase.execute(authToken: "", refreshToken: "")

        completion?(.success(()))
    }
}
