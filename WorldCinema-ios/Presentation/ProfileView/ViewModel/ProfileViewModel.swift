//
//  ProfileViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 09.04.2023.
//

import Combine
import Foundation

class ProfileViewModel: ObservableObject {
    private let getProfileDataUseCase: GetProfileDataUseCase
    private let getTokensUseCase: GetTokensUseCase
    
    init(
        getProfileDataUseCase: GetProfileDataUseCase,
        getTokensUseCase: GetTokensUseCase
         
    ) {
        self.getProfileDataUseCase = getProfileDataUseCase
        self.getTokensUseCase = getTokensUseCase
    }
    
    func getProfileData() {
        getTokensUseCase.execute(tokenType: .auth) { [weak self] result in
            switch result {
                case .success(let token):
                    self?.getProfileDataUseCase.execute(token: token) { [weak self] result in
                        switch result {
                            case .success(let profileData):
                                print(profileData)
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
