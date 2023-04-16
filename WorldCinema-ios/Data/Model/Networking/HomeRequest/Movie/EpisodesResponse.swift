//
//  EpisodesResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Foundation

struct EpisodesResponse: Codable {
    var episodeId: String = ""
    var name: String = ""
    var description: String = ""
    var director: String = ""
    var stars: [String] = [String]()
    var year: Int? = 0
    var images: [String] = [String]()
    var runtime: Int? = 0
    var preview: String = ""
    var filePath: String = ""
    
}
