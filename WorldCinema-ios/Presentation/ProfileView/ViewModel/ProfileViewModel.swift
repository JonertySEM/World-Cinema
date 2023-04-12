//
//  ProfileViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 09.04.2023.
//

import Combine
import Foundation

class ProfileViewModel: ObservableObject, FlowController {
    var completionHandlerButton: ((String?) -> ())?
    var completionHandler: ((String?) -> ())?
    private let getProfileDataUseCase: GetProfileDataUseCase
    private let getTokensUseCase: GetTokensUseCase
    private let logOutUseCase: LogOutUseCase
    private let uploadProfileDataUseCase: UploadProfileDataUseCase
    
    @Published private(set) var isProgressProfileShowing = false
    @Published var avatar = ""
    @Published var userName = ""
    @Published var userEmail = ""
    init(
        getProfileDataUseCase: GetProfileDataUseCase,
        getTokensUseCase: GetTokensUseCase,
        logOutUseCase: LogOutUseCase,
        uploadProfileDataUseCase: UploadProfileDataUseCase
         
    ) {
        self.getProfileDataUseCase = getProfileDataUseCase
        self.getTokensUseCase = getTokensUseCase
        self.logOutUseCase = logOutUseCase
        self.uploadProfileDataUseCase = uploadProfileDataUseCase
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
