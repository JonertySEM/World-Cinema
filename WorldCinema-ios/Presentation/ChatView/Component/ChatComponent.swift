//
//  ChatComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import NeedleFoundation

protocol ChatComponentDependency: Dependency {
    var getProfileDataUseCase: GetProfileDataUseCase { get }
    var getTokensUseCase: GetTokensUseCase { get }
    var logOutUseCase: LogOutUseCase { get }
    var uploadProfileDataUseCase: UploadProfileDataUseCase { get }
    var getChatListUseCase: GetChatListUseCase { get }
}

final class ChatComponent: Component<ChatComponentDependency> {
    var chatViewModel: ChatViewModel {
        shared {
            ChatViewModel()
        }
    }

    var chatViewControlelr: ChatViewController {
        return ChatViewController()
    }
}
