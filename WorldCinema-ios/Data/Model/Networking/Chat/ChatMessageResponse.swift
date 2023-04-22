//
//  ChatMessageResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 21.04.2023.
//

import Foundation

struct ChatMessageResponse: Codable {
    var messageId: String = ""
    var creationDateTime: String = ""
    var authorId: String = ""
    var authorName: String = ""
    var authorAvatar: String = ""
    var text: String = ""
}
