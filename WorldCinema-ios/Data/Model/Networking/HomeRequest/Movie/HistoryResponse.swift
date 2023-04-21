//
//  HistoryResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 21.04.2023.
//

import Foundation

struct HistoryRepsonse: Codable {
    var episodeId: String = ""
    var movieId: String = ""
    var episodeName: String = ""
    var movieName: String = ""
    var preview: String = ""
    var filePath: String = ""
    var time: Int = 0
}
