//
//  GetAuthorizationStatusUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 02.04.2023.
//

import Foundation
import SwiftyUserDefaults

class GetAuthStatusUseCase {
    func execute(completion: ((Result<Bool, Error>) -> Void)? = nil) {
        guard let isAuthorized = Defaults[\.isAuthorized] else {
            completion?(.failure(SwiftyUserDefualtsErrorsEnum.unableToGetData))

            return
        }

        completion?(.success(isAuthorized))
    }
}
