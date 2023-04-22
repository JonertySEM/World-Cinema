//
//  LikeFilmInCollectionUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import NeedleFoundation

protocol LikeFilmInCollectionUseCaseDependency: Dependency {
    var likeFilmInCollectionUseCase: LikeFilmInCollectionUseCase { get }
}

class LikeFilmInCollectionUseCase {
    private var collectionRepository: CollectionRepository

    init(collectionRepository: CollectionRepository) {
        self.collectionRepository = collectionRepository
    }

    func execute(
        token: String,
        collectionId: String,
        movieId: String,
        completion: ((Result<VoidResponse, Error>) -> Void)? = nil
    ) {
        collectionRepository.addMovieInCollection(token: token, collectionId: collectionId, movieId: movieId, completion: completion)
    }
}
