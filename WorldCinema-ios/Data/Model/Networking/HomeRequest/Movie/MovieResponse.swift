//
//  MovieResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation

struct MovieResponse: Codable {
    let movieId: String
    let name: String
    let description: String
    let age: String
    let chatInfo: ChatInfoResponse
    let imageUrls: [String]
    let poster: String
    let tags: [TagResponse]
}
