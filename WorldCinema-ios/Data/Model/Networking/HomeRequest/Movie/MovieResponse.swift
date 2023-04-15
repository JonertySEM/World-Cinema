//
//  MovieResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation

struct MovieResponse: Codable {
    var movieId: String = ""
    var name: String = ""
    var description: String = ""
    var age: String = ""
    var chatInfo: ChatInfoResponse = ChatInfoResponse(chatId: "", chatName: "")
    var imageUrls: [String] = [String]()
    var poster: String = ""
    var tags: [TagResponse] = [TagResponse]()

}
