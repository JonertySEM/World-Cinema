//
//  RegistrationViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Combine
import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var firstNameFieldText = ""
    @Published var secondNameFieldText = ""
    @Published var emailFieldText = ""
    @Published var passwordFieldText = ""
    @Published var confirmPasswordText = ""

    @Published private(set) var isFirstNameTextFieldValid = true
    @Published private(set) var isEmailTextFieldValid = true
    @Published private(set) var isSecondNameTextFieldValid = true
    @Published private(set) var isPasswordTextFieldValid = true
    @Published private(set) var isPasswordTextFieldConfirmationValid = true
    @Published private(set) var arePasswordsTextFieldsEqual = true
    @Published private(set) var areTextFieldsValid = false

    @Published var isAlertShowing = false
    @Published private(set) var alertText = ""

    private var subscribers: Set<AnyCancellable> = []

//    private let registrationUseCase:

    init() {
        initFieldsObserving()
    }

    private func resetValidationState() {
        isFirstNameTextFieldValid = true
        isEmailTextFieldValid = true
        isSecondNameTextFieldValid = true
        isPasswordTextFieldValid = true
        isPasswordTextFieldConfirmationValid = true
        arePasswordsTextFieldsEqual = true
    }

    func cleanFields() {
        resetValidationState()

        firstNameFieldText = ""
        secondNameFieldText = ""
        emailFieldText = ""
        passwordFieldText = ""
        confirmPasswordText = ""
    }

    private func initFieldsObserving() {
        initFirstNameTextObserving()
        initEmailTextObserving()
        initSecondNameTextObserving()
        initPasswordTextObserving()
        initPasswordConfirmationTextObserving()
    }

    private func initFirstNameTextObserving() {
        $firstNameFieldText
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                self.isFirstNameTextFieldValid = true

                validateFields()
            }.store(in: &subscribers)
    }

    private func initEmailTextObserving() {
        $emailFieldText
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                self.isEmailTextFieldValid = true

                validateFields()
            }.store(in: &subscribers)
    }

    private func initSecondNameTextObserving() {
        $secondNameFieldText
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                self.isSecondNameTextFieldValid = true

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

    private func initPasswordConfirmationTextObserving() {
        $confirmPasswordText
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { [self] _ in
                self.isPasswordTextFieldConfirmationValid = true

                validateFields()
            }.store(in: &subscribers)
    }

    @discardableResult private func validateFields() -> Bool {
        resetValidationState()

        if !CheckValidatonHelper.isFirstNameValid(firstNameFieldText) {
            areTextFieldsValid = false
            isFirstNameTextFieldValid = false

            return false
        }

        if !CheckValidatonHelper.isEmailValid(emailFieldText) {
            areTextFieldsValid = false
            isEmailTextFieldValid = false

            return false
        }

        if !CheckValidatonHelper.isSecondNameValid(secondNameFieldText) {
            areTextFieldsValid = false
            isSecondNameTextFieldValid = false

            return false
        }

        if !CheckValidatonHelper.isPasswordValid(passwordFieldText) {
            areTextFieldsValid = false
            isPasswordTextFieldValid = false

            return false
        }

        if !CheckValidatonHelper.isPasswordValid(confirmPasswordText) {
            areTextFieldsValid = false
            isPasswordTextFieldConfirmationValid = false

            return false
        }

        if !CheckValidatonHelper.arePasswordsValid(
            firstPassword: passwordFieldText,
            passwordConfirmation: confirmPasswordText
        ) {
            areTextFieldsValid = false
            arePasswordsTextFieldsEqual = false

            return false
        }

        areTextFieldsValid = true

        return true
    }
}
