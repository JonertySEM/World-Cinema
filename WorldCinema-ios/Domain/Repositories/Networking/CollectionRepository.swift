//
//  CollectionRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 07.04.2023.
//

import Foundation

protocol CollectionRepository {
    func getAllCollection(
        token: String,
        completion: ((Result<[CollectionResponse], Error>) -> Void)?
    )
    
    func createCollection(
        token: String,
        name: String,
        completion: ((Result<CollectionResponse, Error>) -> Void)?
    )
    
    func deleteCollection(
        token: String,
        collectionId: String,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
    
    func getMoviesInCollection(
        token: String,
        collectionId: String,
        completion: ((Result<[MovieResponse], Error>) -> Void)?
    )
    
    func addMovieInCollection(
        token: String,
        collectionId: String,
        movieId: String,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
    
    func dislikeMovie(
        token: String,
        movieId: String,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
    
    func deleteMovieInCollection(
        token: String,
        collectionId: String,
        movieId: String,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
}
