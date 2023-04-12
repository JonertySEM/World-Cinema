//
//  HomeViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Combine
import Foundation
import SPAlert

class HomeViewModel: ObservableObject, FlowController {
    var completionHandlerButton: ((String?) -> ())?
    var completionHandler: ((String?) -> ())?

    private let getCoverHomeViewUseCase: GetCoverHomeViewUseCase
    private let getTokensUseCase: GetTokensUseCase

    @Published private(set) var textMessage = ""

    init(
        getCoverHomeViewUseCase: GetCoverHomeViewUseCase,
        getTokensUseCase: GetTokensUseCase
    ) {
        self.getCoverHomeViewUseCase = getCoverHomeViewUseCase
        self.getTokensUseCase = getTokensUseCase
    }

    private func processError(_ error: Error) {
        textMessage = error.localizedDescription
        let alertView = SPAlertView(title: textMessage, preset: .error)
        alertView.duration = 3
        alertView.present()
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
                                self.processError(error)
                                self.completionHandler?("")
                        }
                    }
                case .failure(let error):
                    self.processError(error)
            }
        }
    }
}
