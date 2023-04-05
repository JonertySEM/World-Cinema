//
//  NetwrokingKeysEnum.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Foundation

enum NetworkingKeysEnum: String, CaseIterable, Identifiable, Codable {
    case getCover
    

    var rawValue: String {
        switch self {
        case .getCover:
            return NetworkingModel.baseUrl + NetworkingModel.coverLine
        }
    }

    var id: String { return self.rawValue }
}
