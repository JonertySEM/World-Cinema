//
//  CompilationViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 21.04.2023.
//

import Foundation
import Combine

class CompilationViewModel {
    
    @Published var compilationCardsMovie = [MovieResponse]()
    @Published var isShowingCards = false
    
    private let getCompilationMovieUseCase: GetCompilationMovieUseCase
    private let getTokensUseCase: GetTokensUseCase
    private let likeFilmInCollectionUseCase: LikeFilmInCollectionUseCase
    
    init(
        getCompilationMovieUseCase: GetCompilationMovieUseCase,
        getTokensUseCase: GetTokensUseCase,
        likeFilmInCollectionUseCase: LikeFilmInCollectionUseCase
    ) {
        self.getCompilationMovieUseCase = getCompilationMovieUseCase
        self.getTokensUseCase = getTokensUseCase
        self.likeFilmInCollectionUseCase = likeFilmInCollectionUseCase
    }
    
//    func likeFilm(movieId: String) {
//        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
//            switch result {
//                case .success(let token):
//                self?.likeFilmInCollectionUseCase.execute(token: token, collectionId: <#T##String#>, movieId: movieId)
//                case .failure(let error):
//                    print(error)
//            }
//
//        }
//    }
    
    func getCardsMovie() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            self?.isShowingCards = false
            switch result{
                case .success(let token):
                self?.getCompilationMovieUseCase.execute(token: token) { [weak self] result in
                    switch result {
                        case .success(let cards):
                            self?.compilationCardsMovie = cards
                            self?.isShowingCards = true
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
