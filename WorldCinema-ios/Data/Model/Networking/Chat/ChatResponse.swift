//
//  ChatResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation

struct ChatResponse: Codable {
    var chatId: String = ""
    var chatName: String = ""
    var lastMessage: ChatMessageResponse?
}
