//
//  HomeViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    private let getCoverHomeViewUseCase: GetCoverHomeViewUseCase
    private let getTokensUseCase: GetTokensUseCase

    init(
        getCoverHomeViewUseCase: GetCoverHomeViewUseCase,
        getTokensUseCase: GetTokensUseCase
    ) {
        self.getCoverHomeViewUseCase = getCoverHomeViewUseCase
        self.getTokensUseCase = getTokensUseCase
    }

    func getCoverInView() {
        getTokensUseCase.execute(tokenType: .auth) { [self] result in
            switch result {
                case .success(let token):
                    getCoverHomeViewUseCase.execute(token: token) { [self] result in
                        switch result {
                            case .success(let cover):
                                print("this is cover url \(cover)")
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
