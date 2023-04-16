//
//  GetEpisodesRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Foundation

protocol GetEpisodesRepository {
    func getEpisodes(
        token: String,
        filmId: String,
        completion: ((Result<[EpisodesResponse], Error>) -> Void)?
    )
}
