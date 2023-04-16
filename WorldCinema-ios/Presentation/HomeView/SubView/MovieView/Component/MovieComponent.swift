//
//  MovieComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 14.04.2023.
//

import Foundation
import NeedleFoundation
import UIKit

protocol MovieComponentProvider: Dependency {
    var getEpisodesUseCase: GetEpisodesUseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }
}

final class MovieComponent: Component<MovieComponentProvider> {
    var movieViewModel: MovieViewModel {
        shared {
            MovieViewModel(getEpisodesUseCase: dependency.getEpisodesUseCase,
                           getTokensUseCase: dependency.getTokensUseCase)
        }
    }

    var movieViewController: UIViewController {
        return MovieViewController(viewModel: movieViewModel)
    }
}
