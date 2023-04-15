//
//  HomeViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Combine
import Foundation
import SPAlert

class HomeViewModel: ObservableObject, FlowController {
    
    var completionHandler: ((String?) -> ())?
    var completionHandlerButton: ((MovieResponse?) -> ())?

    private var getCoverHomeViewUseCase: GetCoverHomeViewUseCase
    private var getTokensUseCase: GetTokensUseCase
    private var getInTrendMovieUseCase: GetInTrendMovieUseCase
    private var getNewMovieUseCase: GetNewMovieUseCase
    private var getLastViewMovieUseCase: GetLastViewMovieUseCase
    private var getForMeMovieUseCase: GetForMeMovieUseCase
    
    @Published var isProgressProfileShowing = false
    @Published private(set) var textMessage = ""
    @Published var filmCover = ""
    
    @Published var movieNewList = [MovieResponse]()
    @Published var movieForMeList = [MovieResponse]()
    @Published var movieInTrend = [MovieResponse]()
    @Published var lastWatchedMovie = MovieResponse()

    init(
        getCoverHomeViewUseCase: GetCoverHomeViewUseCase,
        getTokensUseCase: GetTokensUseCase,
        getInTrendMovieUseCase: GetInTrendMovieUseCase,
        getNewMovieUseCase: GetNewMovieUseCase,
        getLastViewMovieUseCase: GetLastViewMovieUseCase,
        getForMeMovieUseCase: GetForMeMovieUseCase
    ) {
        self.getCoverHomeViewUseCase = getCoverHomeViewUseCase
        self.getTokensUseCase = getTokensUseCase
        self.getInTrendMovieUseCase = getInTrendMovieUseCase
        self.getNewMovieUseCase = getNewMovieUseCase
        self.getLastViewMovieUseCase = getLastViewMovieUseCase
        self.getForMeMovieUseCase = getForMeMovieUseCase
    }

    private func processError(_ error: Error) {
        textMessage = error.localizedDescription
        let alertView = SPAlertView(title: textMessage, preset: .error)
        alertView.duration = 3
        alertView.present()
    }
    
    
    func getNewMovie() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            LoaderView.startLoading()
            self?.isProgressProfileShowing = false
            switch result {
                case .success(let token):
                    self?.getNewMovieUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let newMovie):
                                self?.movieNewList = newMovie
                                LoaderView.endLoading()
                                self?.isProgressProfileShowing = true
                                print(newMovie)
                            case .failure(let error):
                                print(error)
                                LoaderView.endLoading()
                                
                        }
                    }
                case .failure(let error):
                    self?.processError(error)
            }
        }
    }
    
    func getMovieInTrend() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
           
            
            switch result {
                case .success(let token):
                    self?.getInTrendMovieUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let inTrendsMovie):
                                print(inTrendsMovie)
                            case .failure(let error):
                                print(error)
                               
                        }
                    }
                case .failure(let error):
                    self?.processError(error)
            }
        }
    }
    
    func getFilmYouWatched() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            
            switch result {
                case .success(let token):
                self?.getLastViewMovieUseCase.execute(token: token) { [weak self] result in
                    switch result {
                        case .success(let movie):
                            self?.lastWatchedMovie = movie
                        case .failure(let error):
                            print(error)
                    }
                    
                }
                case .failure(let error):
                    self?.processError(error)
            }
            
        }
    }
    
    func getFilmForMe() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            
            switch result {
                case .success(let token):
                self?.getForMeMovieUseCase.execute(token: token) { [weak self] result in
                    switch result {
                        case .success(let movie):
                            self?.movieForMeList = movie
                        case .failure(let error):
                            print(error)
                    }
                    
                }
                case .failure(let error):
                    self?.processError(error)
            }
            
        }
    }

    func getCoverInView() {
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
                case .success(let token):
                    getCoverHomeViewUseCase.execute(token: token) { [self] result in
                        switch result {
                            case .success(let cover):
                                self.filmCover = cover.foregroundImage
                                print("this is cover url \(cover)")
                            case .failure(let error):
                                self.processError(error)
                                self.completionHandler?("")
                        }
                    }
                case .failure(let error):
                    self.processError(error)
            }
        }
    }
}
