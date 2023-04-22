//
//  ChatListViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation

class ChatListViewModel {
    
    private var getChatListUseCase: GetChatListUseCase
    private var getTokensUseCase: GetTokensUseCase
    
    @Published var listOfChats = [ChatResponse?]()
    @Published var isProgressChatShowing = false
    
    init(
        getChatListUseCase: GetChatListUseCase,
        getTokensUseCase: GetTokensUseCase
    ) {
        self.getChatListUseCase = getChatListUseCase
        self.getTokensUseCase = getTokensUseCase
    }
    
    func getChatList(){
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            self?.isProgressChatShowing = false
            switch result {
                case .success(let token):
                self?.getChatListUseCase.execute(token: token) { [weak self] result in
                    switch result {
                        case .success(let chatList):
                        self?.listOfChats = chatList
                        self?.isProgressChatShowing = true
                        case .failure(let error):
                            print(error)
                    }
                }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    
}
