//
//  KeyChainRepositoryErrorEnum.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation

enum KeychainRepositoryErrorsEnum: Error {
    case unableToSaveValue
    case unableToGetSavedValue
}

extension KeychainRepositoryErrorsEnum: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToSaveValue: return "Ошибка сохранения значения"
        case .unableToGetSavedValue: return "Ошибка получения сохраненного значения"
        }
    }
}
