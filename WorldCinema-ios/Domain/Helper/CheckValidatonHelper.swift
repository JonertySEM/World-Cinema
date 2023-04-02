//
//  CheckValidatonHelper.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation

class CheckValidatonHelper {
    private static let emailRegex = NSPredicate(
        format: "SELF MATCHES %@",
        // swiftlint:disable:next line_length
        "^(?!\\.)([A-Z0-9a-z_%+-]?[\\.]?[A-Z0-9a-z_%+-])+@[A-Za-z0-9-]{1,20}(\\.[A-Za-z0-9]{1,15}){0,10}\\.[A-Za-z]{2,20}$"
    )

    static func isPasswordValid(_ password: String) -> Bool {
        !password.isEmptyTextField
    }

    static func isSecondNameValid(_ secondName: String) -> Bool {
        !secondName.isEmptyTextField
    }

    static func isFirstNameValid(_ firstName: String) -> Bool {
        !firstName.isEmptyTextField
    }

    static func isEmailValid(_ email: String) -> Bool {
        emailRegex.evaluate(with: email)
    }

    static func arePasswordsValid(firstPassword: String, passwordConfirmation: String) -> Bool {
        firstPassword == passwordConfirmation
    }
}
