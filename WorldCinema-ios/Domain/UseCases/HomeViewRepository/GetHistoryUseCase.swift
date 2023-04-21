//
//  GetHistoryUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 21.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetHistoryUseCaseProvider: Dependency {
    var getHistoryUseCase: GetHistoryUseCase { get }
}

class GetHistoryUseCase {
    private var getHistoryFilmRepository: GetHistoryFilmRepository

    init(getHistoryFilmRepository: GetHistoryFilmRepository) {
        self.getHistoryFilmRepository = getHistoryFilmRepository
    }

    func execute(token: String,
                 completion: ((Result<[HistoryRepsonse?], Error>) -> Void)? = nil)
    {
        getHistoryFilmRepository.getHistory(token: token, completion: completion)
    }
}
