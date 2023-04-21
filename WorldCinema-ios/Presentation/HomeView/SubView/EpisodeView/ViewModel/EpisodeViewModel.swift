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
    private var getTokensUseCase: GetTokensUseCase
    @Published var isPlaying = false
    
    @Published var film = MovieResponse()
    @Published var episode = EpisodesResponse()
    @Published var countEpisode = 0
    @Published var timeEpisode: Int?
    
    init(
        getTimeEpisodeUseCase: GetTimeEpisodeUseCase,
        saveTimeEpisodeUseCase: SaveTimeEpisodeUseCase,
        getTokensUseCase: GetTokensUseCase
    ) {
        self.getTimeEpisodeUseCase = getTimeEpisodeUseCase
        self.saveTimeEpisodeUseCase = saveTimeEpisodeUseCase
        self.getTokensUseCase = getTokensUseCase
    }
    
    func getTimeMovie() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            switch result {
                case .success(let token):
                    self?.getTimeEpisodeUseCase.execute(token: token, episodeId: self?.episode.episodeId ?? "") { [weak self] result in
                        switch result {
                            case .success(let episodeTime):
                                self?.timeEpisode = episodeTime.timeInSeconds
                            case .failure(let error):
                                print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func saveTimeEpisode(timeRequest: Int?) {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            switch result {
                case .success(let token):
                    self?.saveTimeEpisodeUseCase.execute(token: token, episodeId: self?.episode.episodeId ?? "", timeRequest: timeRequest) { result in
                        switch result {
                            case .success:
                                print("time saved")
                            case .failure(let error):
                                print(error)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
}
