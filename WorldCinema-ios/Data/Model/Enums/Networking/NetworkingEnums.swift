//
//  NetworkingEnums.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 26.03.2023.
//

import Foundation

enum NetworkingEnums: Error {
    case unableToGetData
    case wrongUserCredentials
    case invalidUserCredentials
}

extension NetworkingEnums: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidUserCredentials: return "Неверная почта или пароль"
        case .unableToGetData: return "Нельзя получить данные"
        case .wrongUserCredentials: return "Неверные данные пользователя"
        }
    }

    static func getErrorDescription(str: String) -> String {
        switch str {
        case "InvalidUserCredentials":
            return "Неверная почта или пароль"
        case "InternalServerError" :
            return "Проблема на стороне сервера"
        case "unableToGetData" :
            return "Невозможно получить данные с сервера"
        case "UserAlreadyExists" :
            return "Пользователь с такой почтой уже зарегистрирован"
        default:
            return ""
        }
    }
}
