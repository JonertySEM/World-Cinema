//
//  GetEpisodesUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetEpisodesUseCaseDependency: Dependency {
    var getEpisodesUseCase: GetCoverHomeViewUseCase { get }
}

class GetEpisodesUseCase {
    private let getEpisodesRepository: GetEpisodesRepository

    init(getEpisodesRepository: GetEpisodesRepository) {
        self.getEpisodesRepository = getEpisodesRepository
    }

    func execute(token: String, filmId: String,
                 completion: ((Result<[EpisodesResponse], Error>) -> Void)? = nil)
    {
        getEpisodesRepository.getEpisodes(token: token, filmId: filmId,
                                          completion: completion)
    }
}
