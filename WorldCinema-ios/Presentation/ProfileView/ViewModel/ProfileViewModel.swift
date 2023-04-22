//
//  ProfileViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 09.04.2023.
//

import Combine
import Foundation

class ProfileViewModel: ObservableObject, FlowController {
    var completionHandlerButton: ((String) -> ())?
    var completionHandler: ((String) -> ())?
    private let getProfileDataUseCase: GetProfileDataUseCase
    private let getTokensUseCase: GetTokensUseCase
    private let logOutUseCase: LogOutUseCase
    private let uploadProfileDataUseCase: UploadProfileDataUseCase
    private let getChatListUseCase: GetChatListUseCase
    
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var isProgressProfileShowing = false
    @Published var isProgressChatShowing = false
    @Published var isProgress = false
    @Published var avatar = ""
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var listOfChats = [ChatResponse?]()
    init(
        getProfileDataUseCase: GetProfileDataUseCase,
        getTokensUseCase: GetTokensUseCase,
        logOutUseCase: LogOutUseCase,
        uploadProfileDataUseCase: UploadProfileDataUseCase,
        getChatListUseCase: GetChatListUseCase
         
    ) {
        self.getProfileDataUseCase = getProfileDataUseCase
        self.getTokensUseCase = getTokensUseCase
        self.logOutUseCase = logOutUseCase
        self.uploadProfileDataUseCase = uploadProfileDataUseCase
        self.getChatListUseCase = getChatListUseCase
        
        initFieldsObserving()
    }
    
    
    private func initFieldsObserving() {
        initProfileShowing()
        initChatsShowing()
        
    }

    private func initProfileShowing() {
        $isProgressProfileShowing
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                
                getAllRepsonse()
            }.store(in: &subscribers)
    }
    
    private func initChatsShowing() {
        $isProgressChatShowing
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                
                getAllRepsonse()
            }.store(in: &subscribers)
    }
    
    private func getAllRepsonse() {
        if isProgressChatShowing && isProgressProfileShowing {
            isProgress = true
        }
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
    
    
    func pressExit() {
        logOutUseCase.execute(isAuthorized: false)
        completionHandler?("")
    }
    
    func uploadAvatar(data: Data?) {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            switch result {
                case .success(let token):
                    self?.uploadProfileDataUseCase.execute(token: token, imageData: data) { [weak self] result in
                        switch result {
                            case .success:
                                print("image uploded")
                            case .failure(let error):
                                print("image doesnt uploded")
                                print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func saveProfileData(data: ProfileResponse) {
        userName = data.firstName + " " + data.lastName
        avatar = data.avatar ?? ""
        userEmail = data.email
    }
    
    func getProfileData() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            self?.isProgressProfileShowing = false
            switch result {
                case .success(let token):
                    self?.getProfileDataUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let profileData):
                                print(profileData)
                                self?.saveProfileData(data: profileData)
                                self?.isProgressProfileShowing = true
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
