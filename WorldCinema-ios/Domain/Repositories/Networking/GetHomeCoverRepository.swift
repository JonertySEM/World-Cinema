//
//  GetHomeCoverRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation

protocol GetHomeCoverRepository {
    
    func getCover(
        token: String,
        completion: ((Result<CoverResponse, Error>) -> Void)?
    )
}
