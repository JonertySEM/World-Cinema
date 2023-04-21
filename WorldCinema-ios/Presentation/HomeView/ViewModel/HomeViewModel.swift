//
//  HomeViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Combine
import Foundation
import SPAlert

class HomeViewModel: ObservableObject, FlowController, AddEpisode {
    var completionHandler: ((String?) -> ())?
    var completionHandlerButton: ((MovieResponse?) -> ())?
    var tapEpisode: (((MovieResponse, HistoryRepsonse)) -> ())?
    
    private var subscribers: Set<AnyCancellable> = []

    private var getCoverHomeViewUseCase: GetCoverHomeViewUseCase
    private var getTokensUseCase: GetTokensUseCase
    private var getInTrendMovieUseCase: GetInTrendMovieUseCase
    private var getNewMovieUseCase: GetNewMovieUseCase
    private var getLastViewMovieUseCase: GetLastViewMovieUseCase
    private var getForMeMovieUseCase: GetForMeMovieUseCase
    private var getHistoryUseCase: GetHistoryUseCase
    
    @Published var isProgressNewFilmShowing = false
    @Published var isProgressForMeFilmShowing = false
    @Published var isProgressInTrendShowing = false
    @Published var isProgressFilmYouWatchedShowing = false
    @Published var isProgressFilmYouWatchedHomeShowing = false
    @Published var isProgressShowing = false
    @Published private(set) var textMessage = ""
    @Published var filmCover = ""
    
    @Published var movieNewList = [MovieResponse]()
    @Published var movieForMeList = [MovieResponse]()
    @Published var movieInTrend = [MovieResponse]()
    @Published var lastWatchedMovie = [MovieResponse?]()
    @Published var lastWatchMovieInHome = MovieResponse()
    @Published var historyMovie = [HistoryRepsonse?]()

    init(
        getCoverHomeViewUseCase: GetCoverHomeViewUseCase,
        getTokensUseCase: GetTokensUseCase,
        getInTrendMovieUseCase: GetInTrendMovieUseCase,
        getNewMovieUseCase: GetNewMovieUseCase,
        getLastViewMovieUseCase: GetLastViewMovieUseCase,
        getForMeMovieUseCase: GetForMeMovieUseCase,
        getHistoryUseCase: GetHistoryUseCase
    ) {
        self.getCoverHomeViewUseCase = getCoverHomeViewUseCase
        self.getTokensUseCase = getTokensUseCase
        self.getInTrendMovieUseCase = getInTrendMovieUseCase
        self.getNewMovieUseCase = getNewMovieUseCase
        self.getLastViewMovieUseCase = getLastViewMovieUseCase
        self.getForMeMovieUseCase = getForMeMovieUseCase
        self.getHistoryUseCase = getHistoryUseCase
        
        initNewShowing()
    }

    private func processError(_ error: Error) {
        textMessage = error.localizedDescription
        let alertView = SPAlertView(title: textMessage, preset: .error)
        alertView.duration = 3
        alertView.present()
    }
    
    private func initFieldsObserving() {
        initInTrendShowing()
        initForMeFilmShowing()
        initYouWatchedShowing()
        initNewShowing()
    }

    private func initInTrendShowing() {
        $isProgressInTrendShowing
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                
                getAllRepsonse()
            }.store(in: &subscribers)
    }
    
    private func initYouWatchedShowing() {
        $isProgressFilmYouWatchedShowing
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                
                getAllRepsonse()
            }.store(in: &subscribers)
    }
    
    private func initYouWatchedHomeShowing() {
        $isProgressFilmYouWatchedHomeShowing
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                
                getAllRepsonse()
            }.store(in: &subscribers)
    }

    private func initNewShowing() {
        $isProgressNewFilmShowing
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                
                getAllRepsonse()
            }.store(in: &subscribers)
    }

    private func initForMeFilmShowing() {
        $isProgressForMeFilmShowing
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                
                getAllRepsonse()
            }.store(in: &subscribers)
    }
    
    func getNewMovie() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            self?.isProgressNewFilmShowing = false
            switch result {
                case .success(let token):
                    self?.getNewMovieUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let newMovie):
                                self?.movieNewList = newMovie
                                self?.isProgressNewFilmShowing = true
                                print("new films is showing")
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
    
    func getFilmYouWatched() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            self?.isProgressFilmYouWatchedHomeShowing = false
            switch result {
                case .success(let token):
                    self?.getLastViewMovieUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let movie):
                                self?.lastWatchMovieInHome = movie[movie.count - 1] ?? MovieResponse()
                                self?.isProgressFilmYouWatchedHomeShowing = true
                            case .failure(let error):
                                print(error)
                        }
                    }
                case .failure(let error):
                    self?.processError(error)
            }
        }
    }

    func getHistoryMovie() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            self?.isProgressFilmYouWatchedShowing = false
            switch result {
                case .success(let token):
                    self?.getHistoryUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let history):
                                self?.historyMovie = history
                                self?.isProgressFilmYouWatchedShowing = true
                            case .failure(let error):
                                self?.processError(error)
                        }
                    }
                case .failure(let error):
                    self?.processError(error)
            }
        }
    }
    
    func getMovieInTrend() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            self?.isProgressInTrendShowing = false
            
            switch result {
                case .success(let token):
                    self?.getInTrendMovieUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let inTrendsMovie):
                                self?.movieInTrend = inTrendsMovie
                                self?.isProgressInTrendShowing = true
                                print("in trend films is showing")
                            case .failure(let error):
                                print(error)
                        }
                    }
                case .failure(let error):
                    self?.processError(error)
            }
        }
    }

    private func getAllRepsonse() {
        LoaderView.startLoading()
        if isProgressInTrendShowing && isProgressNewFilmShowing && isProgressForMeFilmShowing && isProgressFilmYouWatchedShowing && isProgressFilmYouWatchedHomeShowing {
            isProgressShowing = true
            LoaderView.endLoading()
        }
    }
    
    func getFilmForMe() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            self?.isProgressForMeFilmShowing = false
            switch result {
                case .success(let token):
                    self?.getForMeMovieUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let movie):
                                self?.movieForMeList = movie
                                self?.isProgressForMeFilmShowing = true
                                print("film for me is showing")
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
