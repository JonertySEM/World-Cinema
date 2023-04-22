//
//  CollectionComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import Foundation
import NeedleFoundation

protocol CollectionComponentDependency: Dependency {
    
}


final class CollectionComponent: Component <CollectionComponentDependency> {
    
    var collectionViewModel: CollectionViewModel {
        shared {
            CollectionViewModel()
        }
    }
    
    var collectionViewController: CollectionViewController {
        return CollectionViewController(viewModel: collectionViewModel)
    }
}
