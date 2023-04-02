//
//  SaveAuthorizationStatusUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 02.04.2023.
//

import Foundation
import SwiftyUserDefaults

class SaveAuthStatusUseCase {
    func execute(isAuthorized: Bool, completion: ((Result<Void, Error>) -> Void)? = nil) {
        Defaults[\.isAuthorized] = isAuthorized

        completion?(.success(()))
    }
}
