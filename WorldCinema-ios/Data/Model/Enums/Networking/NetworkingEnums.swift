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
}

extension NetworkingEnums: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToGetData: return "Нельзя получить данные"
        case .wrongUserCredentials: return "Неверные данные пользователя"
        }
    }
}
