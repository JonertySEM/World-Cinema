//
//  GetNewMovieUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetNewMovieUseCaseProvider: Dependency {
    var getNewMovieUseCase: GetNewMovieUseCase { get }
}


class GetNewMovieUseCase {
    private var movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(token: String,
                 completion: ((Result<[MovieResponse], Error>) -> Void)? = nil) {
        movieRepository.getNewMovie(token: token, completion: completion)
    }
}
