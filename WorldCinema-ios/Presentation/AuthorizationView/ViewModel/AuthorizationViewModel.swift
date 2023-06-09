//
//  AuthorizationViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 30.03.2023.
//

import Combine
import Foundation
import SPAlert

class AuthorizationViewModel: ObservableObject, FlowController {
    var completionHandlerButton: ((String?) -> ())?
    var completionHandler: ((String?) -> ())?
    @Published var emailFieldText = ""
    @Published var passwordFieldText = ""
    
    @Published private(set) var isEmailTextFieldValid = true
    @Published private(set) var isPasswordTextFieldValid = true
    @Published private(set) var areTextFieldsValid = false

    @Published var isAlertShowing = false
    @Published private(set) var textMessage = ""
    
    private var subscribers: Set<AnyCancellable> = []
    
    private let loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
        
        initFieldsObserving()
    }
    
    private func resetValidation() {
        isEmailTextFieldValid = true
        isPasswordTextFieldValid = true
    }

    func cleanFields() {
        resetValidation()

        emailFieldText = ""
        passwordFieldText = ""
    }
    
    private func initFieldsObserving() {
        initEmailTextObserving()
        initPasswordTextObserving()
    }

    private func initEmailTextObserving() {
        $emailFieldText
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                self.isEmailTextFieldValid = true
                
                validateFields()
            }.store(in: &subscribers)
    }

    private func initPasswordTextObserving() {
        $passwordFieldText
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                self.isPasswordTextFieldValid = true
            
                validateFields()
            }.store(in: &subscribers)
    }
    
    @discardableResult
    private func validateFields() -> Bool {
        if !CheckValidatonHelper.isEmailValid(emailFieldText) {
            areTextFieldsValid = false
            return false
        }
        if !CheckValidatonHelper.isPasswordValid(passwordFieldText) {
            areTextFieldsValid = false
            return false
        }
        areTextFieldsValid = true
        return true
    }
    
    private func processError(_ error: Error) {
        textMessage = error.localizedDescription
        let alertView = SPAlertView(title: textMessage, preset: .error)
        alertView.duration = 3
        alertView.present()
    }
    
    func login() {
        if validateFields() {
            LoaderView.startLoading()
            loginUseCase.execute(
                authorizationRequest: AuthorizationRequest(
                    email: emailFieldText,
                    password: passwordFieldText
                )
            ) { [weak self] result in
                LoaderView.endLoading()
        
                if case .failure(let error) = result {
                    self?.processError(error)
                } else {
                    self?.completionHandler?("")
                }
            }
        }
    }
    
    func changeView() {
        completionHandlerButton?("")
    }
}
