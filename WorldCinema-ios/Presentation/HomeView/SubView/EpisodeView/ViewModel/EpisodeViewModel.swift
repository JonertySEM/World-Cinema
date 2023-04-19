//
//  EpisodeViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 18.04.2023.
//

import Combine
import Foundation

class EpisodeViewModel: ObservableObject {
    private var getTimeEpisodeUseCase: GetTimeEpisodeUseCase
    private var saveTimeEpisodeUseCase: SaveTimeEpisodeUseCase
    @Published var isPlaying = false
    
    init(
        getTimeEpisodeUseCase: GetTimeEpisodeUseCase,
        saveTimeEpisodeUseCase: SaveTimeEpisodeUseCase
    ) {
        self.getTimeEpisodeUseCase = getTimeEpisodeUseCase
        self.saveTimeEpisodeUseCase = saveTimeEpisodeUseCase
    }
    
    @Published var film = MovieResponse()
    @Published var episode = EpisodesResponse()
    @Published var countEpisode = 0
}
