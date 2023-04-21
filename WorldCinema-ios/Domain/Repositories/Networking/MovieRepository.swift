//
//  MovieRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation
protocol MovieRepository {
    func getNewMovie(
        token: String,
        completion: ((Result<[MovieResponse], Error>) -> Void)?
    )

    func getInTrendMovie(
        token: String,
        completion: ((Result<[MovieResponse], Error>) -> Void)?
    )

    func getForMeMovie(
        token: String,
        completion: ((Result<[MovieResponse], Error>) -> Void)?
    )

    func getLastViewMovie(
        token: String,
        completion: ((Result<[MovieResponse?], Error>) -> Void)?
    )

    func getCompilationMovie(
        token: String,
        completion: ((Result<[MovieResponse], Error>) -> Void)?
    )
}
