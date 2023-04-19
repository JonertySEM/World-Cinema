//
//  GetTimeEpisodeUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 19.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetTimeEpisodeUseCaseDependency: Dependency {
    var getTimeEpisodeUseCase: GetTimeEpisodeUseCase { get }
}

class GetTimeEpisodeUseCase {
    private var timeEpisodesRepository: TimeEpisodesRepository

    init(timeEpisodesRepository: TimeEpisodesRepository) {
        self.timeEpisodesRepository = timeEpisodesRepository
    }

    func execute(token: String,
                 episodeId: String,
                 completion: ((Result<EpisodesTime, Error>) -> Void)?)
    {
        timeEpisodesRepository.getTimePosition(token: token, episodeId: episodeId, completion: completion)
    }
}
