//
//  GetCoverHomeViewUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetCoverHomeViewUseCaseDependency: Dependency {
    var getCoverHomeViewUseCase: GetCoverHomeViewUseCase { get }
}

class GetCoverHomeViewUseCase {
    private let getHomeCoverRepository: GetHomeCoverRepository

    init(getHomeCoverRepository: GetHomeCoverRepository) {
        self.getHomeCoverRepository = getHomeCoverRepository
    }

    func execute(token: String,
                 completion: ((Result<CoverResponse, Error>) -> Void)? = nil)
    {
        getHomeCoverRepository.getCover(token: token, completion: completion)
    }
}
