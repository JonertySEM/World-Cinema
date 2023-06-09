//
//  CompilationComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import Foundation
import NeedleFoundation

protocol CompilationComponentDependency: Dependency {
    var getCompilationMovieUseCase: GetCompilationMovieUseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }
    var likeFilmInCollectionUseCase: LikeFilmInCollectionUseCase { get }
}

final class CompilationComponent: Component<CompilationComponentDependency> {
    var compilationViewModel: CompilationViewModel {
        shared {
            CompilationViewModel(getCompilationMovieUseCase: dependency.getCompilationMovieUseCase, getTokensUseCase: dependency.getTokensUseCase, likeFilmInCollectionUseCase: dependency.likeFilmInCollectionUseCase)
        }
    }
    
    var compilationViewController: CompilationViewController {
        return CompilationViewController(viewModel: compilationViewModel)
    }
}
