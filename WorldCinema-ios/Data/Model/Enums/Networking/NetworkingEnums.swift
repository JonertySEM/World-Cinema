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
        case .invalidUserCredentials: return R.string.localizable.invalidUserCredentials()
        case .unableToGetData: return R.string.localizable.unableToGetData()
        case .wrongUserCredentials: return R.string.localizable.wrongUserCredentials()
        }
    }

    static func getErrorDescription(str: String) -> String {
        switch str {
        case "InvalidUserCredentials":
            return R.string.localizable.invalidUserCredentials()
        case "InternalServerError":
            return R.string.localizable.internalServerError()
        case "unableToGetData":
            return R.string.localizable.unableToGetData()
        case "UserAlreadyExists":
            return R.string.localizable.userAlreadyExists()
        default:
            return R.string.localizable.unableToGetData()
        }
    }
}
