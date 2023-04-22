//
//  GetChatListUseCase.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import NeedleFoundation

protocol GetChatListUseCaseDependency: Dependency {
    var getChatListUseCase: GetChatListUseCase { get }
}


class GetChatListUseCase {
    private var chatRepository: ChatRepository
    
    init(chatRepository: ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func execute(
        token: String,
        completion: ((Result<[ChatResponse?], Error>) -> Void)? = nil
    ) {
        chatRepository.getChatsList(token: token, completion: completion)
    }
    
    
}
