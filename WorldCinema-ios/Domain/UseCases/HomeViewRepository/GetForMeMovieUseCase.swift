//
//  GetForMeMovieUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetForMeMovieUseCaseProvider: Dependency {
    var getForMeMovieUseCase: GetForMeMovieUseCase { get }
}


class GetForMeMovieUseCase {
    private var movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(token: String,
                 completion: ((Result<MovieResponse, Error>) -> Void)? = nil) {
        movieRepository.getForMeMovie(token: token, completion: completion)
    }
}
