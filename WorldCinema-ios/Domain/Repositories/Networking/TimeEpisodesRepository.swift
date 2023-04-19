//
//  GetTimeEpisodesRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 18.04.2023.
//

import Foundation

protocol TimeEpisodesRepository {
    func getTimePosition(
        token: String,
        episodeId: String,
        completion: ((Result<EpisodesTime, Error>) -> Void)?
    )

    func saveTimePosition(
        token: String,
        episodeId: String,
        timeRequest: EpisodesTime,
        completion: ((Result<VoidResponse, Error>) -> Void)?
    )
}
