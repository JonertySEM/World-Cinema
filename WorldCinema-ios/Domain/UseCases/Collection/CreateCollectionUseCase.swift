//
//  CreateCollectionUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 21.04.2023.
//

import Foundation
import NeedleFoundation

protocol CreateCollectionUseCaseDependency: Dependency {
    var createCollectionUseCase: CreateCollectionUseCase { get }
}

class CreateCollectionUseCase {
    private var collectionRepository: CollectionRepository
    
    init(collectionRepository: CollectionRepository) {
        self.collectionRepository = collectionRepository
    }
    
    func execute(
        token: String,
        name: String,
        completion: ((Result<CollectionResponse, Error>) -> Void)? = nil
    ) {
        collectionRepository.createCollection(token: token, name: name, completion: completion)
    }
}
