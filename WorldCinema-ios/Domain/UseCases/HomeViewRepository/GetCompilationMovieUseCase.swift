//
//  GetCompilationMovieUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetCompilationMovieUseCaseProvider: Dependency {
    var getCompilationMovieUseCase: GetCompilationMovieUseCase { get }
}


class GetCompilationMovieUseCase {
    private var movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(token: String,
                 completion: ((Result<[MovieResponse], Error>) -> Void)? = nil) {
        movieRepository.getCompilationMovie(token: token, completion: completion)
    }
}
