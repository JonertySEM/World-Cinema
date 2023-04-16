//
//  MovieViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 15.04.2023.
//

import Combine
import Foundation

class MovieViewModel: FlowController {
    var completionHandler: ((String?) -> ())?
    var completionHandlerButton: ((MovieResponse?) -> ())?
    
    @Published var film = MovieResponse()
    @Published var episodes = [EpisodesResponse]()
    
    @Published var isProgressProfileShowing = false
    
    private var getEpisodesUseCase: GetEpisodesUseCase
    private var getTokensUseCase: GetTokensUseCase
    
    init(
        getEpisodesUseCase: GetEpisodesUseCase,
        getTokensUseCase: GetTokensUseCase
    
    ) {
        self.getEpisodesUseCase = getEpisodesUseCase
        self.getTokensUseCase = getTokensUseCase
    }
    
    func getFilmData(filmData: MovieResponse) {
        film = filmData
    }
    
    func getEpisodes() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            LoaderView.startLoading()
            self?.isProgressProfileShowing = false
            switch result {
                case .success(let token):
                    self?.getEpisodesUseCase.execute(
                        token: token, filmId: self!.film.movieId) { [weak self] result in
                            switch result {
                                case .success(let episodes):
                                    self?.episodes = episodes
                                    LoaderView.endLoading()
                                    self?.isProgressProfileShowing = true
                                   
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
