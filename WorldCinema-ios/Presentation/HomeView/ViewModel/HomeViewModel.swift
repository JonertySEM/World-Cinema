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
    var completionHandlerButton: ((String?) -> ())?
    var completionHandler: ((String?) -> ())?

    private let getCoverHomeViewUseCase: GetCoverHomeViewUseCase
    private let getTokensUseCase: GetTokensUseCase
    private var getInTrendMovieUseCase: GetInTrendMovieUseCase
    private var getNewMovieUseCase: GetNewMovieUseCase

    @Published private(set) var textMessage = ""

    init(
        getCoverHomeViewUseCase: GetCoverHomeViewUseCase,
        getTokensUseCase: GetTokensUseCase,
        getInTrendMovieUseCase: GetInTrendMovieUseCase,
        getNewMovieUseCase: GetNewMovieUseCase
    ) {
        self.getCoverHomeViewUseCase = getCoverHomeViewUseCase
        self.getTokensUseCase = getTokensUseCase
        self.getInTrendMovieUseCase = getInTrendMovieUseCase
        self.getNewMovieUseCase = getNewMovieUseCase
    }

    private func processError(_ error: Error) {
        textMessage = error.localizedDescription
        let alertView = SPAlertView(title: textMessage, preset: .error)
        alertView.duration = 3
        alertView.present()
    }
    
    
    func getNewMovie() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            
            switch result {
                case .success(let token):
                    self?.getNewMovieUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let newMovie):
                                print(newMovie)
                            case .failure(let error):
                                print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
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
                                for movie in inTrendsMovie {
//                                    print(movie)
//                                    print("1111")
                                }
                            case .failure(let error):
                                print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
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
