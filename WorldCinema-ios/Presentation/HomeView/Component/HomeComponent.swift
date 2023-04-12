//
//  HomeComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation
import NeedleFoundation
import UIKit

protocol HomeComponentDependency: Dependency {
    var getCoverHomeViewUseCase: GetCoverHomeViewUseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }
    var getInTrendMovieUseCase: GetInTrendMovieUseCase { get }
    var getNewMovieUseCase: GetNewMovieUseCase { get }
}

final class HomeComponent: Component<HomeComponentDependency> {
    var homeViewModel: HomeViewModel {
        shared {
            HomeViewModel(getCoverHomeViewUseCase: dependency.getCoverHomeViewUseCase,
                          getTokensUseCase: dependency.getTokensUseCase, getInTrendMovieUseCase: dependency.getInTrendMovieUseCase, getNewMovieUseCase: dependency.getNewMovieUseCase)
        }
    }

    var homeViewController: UIViewController {
        return HomeViewController(viewModel: homeViewModel)
    }
}
