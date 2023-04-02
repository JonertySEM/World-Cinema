//
//  SwiftyUserDefaultsEnum.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 02.04.2023.
//

import Foundation

enum SwiftyUserDefualtsErrorsEnum: Error {
    case unableToGetData
}

extension SwiftyUserDefualtsErrorsEnum: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToGetData: return "Невозможно получить данные"
        }
    }
}
