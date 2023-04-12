//
//  GetInTrendMovieUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetInTrendMovieUseCaseProvider: Dependency {
    var getInTrendMovieUseCase: GetInTrendMovieUseCase { get }
}


class GetInTrendMovieUseCase {
    private var movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(token: String,
                 completion: ((Result<[MovieResponse], Error>) -> Void)? = nil) {
        movieRepository.getInTrendMovie(token: token, completion: completion)
    }
}
