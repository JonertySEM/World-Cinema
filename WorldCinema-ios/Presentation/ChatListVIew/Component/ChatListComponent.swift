//
//  ChatListComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import NeedleFoundation

protocol ChatListComponentDependency: Dependency {
    var getProfileDataUseCase: GetProfileDataUseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }
    var logOutUseCase: LogOutUseCase { get }
    var uploadProfileDataUseCase: UploadProfileDataUseCase { get }
    var getChatListUseCase: GetChatListUseCase { get }
}

final class ChatListComponent: Component<ChatListComponentDependency> {
    var chatListViewModel: ChatListViewModel {
        shared {
            ChatListViewModel(getChatListUseCase: dependency.getChatListUseCase, getTokensUseCase: dependency.getTokensUseCase)
        }
    }

    var chatListViewController: ChatListViewController {
        return ChatListViewController(viewModel: chatListViewModel)
    }
}
