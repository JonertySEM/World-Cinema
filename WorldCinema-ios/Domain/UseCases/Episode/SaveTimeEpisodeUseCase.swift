//
//  SaveTimeEpisodeUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 19.04.2023.
//

import Foundation
import NeedleFoundation

protocol SaveTimeEpisodeUseCaseDependency: Dependency {
    var saveTimeEpisodeUseCase: SaveTimeEpisodeUseCase { get }
}

class SaveTimeEpisodeUseCase {
    private var timeEpisodesRepository: TimeEpisodesRepository

    init(timeEpisodesRepository: TimeEpisodesRepository) {
        self.timeEpisodesRepository = timeEpisodesRepository
    }

    func execute(token: String,
                 episodeId: String,
                 timeRequest: Int?,
                 completion: ((Result<VoidResponse, Error>) -> Void)? = nil)
    {
        timeEpisodesRepository.saveTimePosition(token: token, episodeId: episodeId, timeRequest: timeRequest, completion: completion)
    }
}
