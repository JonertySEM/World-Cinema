//
//  ChatRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation

protocol ChatRepository {
    func getChatsList(
        token: String,
        completion: ((Result<[ChatResponse?], Error>) -> Void)?
    )
    
    func getInfoAboutChat(
        token: String,
        chatId: String,
        completion: ((Result<String, Error>) -> Void)?
    )
    
    func getListMessagesInChat(
        token: String,
        chatId: String,
        completion: ((Result<ChatMessageResponse, Error>) -> Void)?
    )
    
    func addMessageInChat(
        token: String,
        chatId: String,
        text: String,
        completion: ((Result <ChatMessageResponse, Error>) -> Void)?
    )
}
