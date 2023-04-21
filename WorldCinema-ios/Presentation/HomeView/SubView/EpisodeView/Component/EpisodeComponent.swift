//
//  EpisodeComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 18.04.2023.
//

import Foundation
import NeedleFoundation
import UIKit

protocol EpisodeComponentProvider: Dependency {
    var getTimeEpisodeUseCase: GetTimeEpisodeUseCase { get }
    var saveTimeEpisodeUseCase: SaveTimeEpisodeUseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }
}

final class EpisodeComponent: Component<EpisodeComponentProvider> {
    var episodeViewModel: EpisodeViewModel {
        shared {
            EpisodeViewModel(
                getTimeEpisodeUseCase: dependency.getTimeEpisodeUseCase,
                saveTimeEpisodeUseCase: dependency.saveTimeEpisodeUseCase,
                getTokensUseCase: dependency.getTokensUseCase
            )
        }
    }

    var episodeViewController: UIViewController {
        return EpisodeViewController(viewModel: episodeViewModel)
    }
}
