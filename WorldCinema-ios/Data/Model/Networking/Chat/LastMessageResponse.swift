//
//  LastMessageResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation

struct LastMessageResponse: Codable {
    var messageId: String = ""
    var creationDateTime: String = ""
    var authorId: String = ""
    var authorName: String = ""
    var authorAvatar: String = ""
    var text: String = ""
}
