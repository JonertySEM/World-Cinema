//
//  GetLastViewMovieUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetLastViewMovieUseCaseProvider: Dependency {
    var getLastViewMovieUseCase: GetLastViewMovieUseCase { get }
}


class GetLastViewMovieUseCase {
    private var movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(token: String,
                 completion: ((Result<[MovieResponse?], Error>) -> Void)? = nil) {
        movieRepository.getLastViewMovie(token: token, completion: completion)
    }
}
