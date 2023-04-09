//
//  NetwrokingKeysEnum.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Foundation

enum NetworkingKeysEnum: String, CaseIterable, Identifiable, Codable {
    case getCover
    case getProfile
    

    var rawValue: String {
        switch self {
        case .getCover:
            return NetworkingModel.baseUrl + NetworkingModel.coverLine
            
        case .getProfile:
            return NetworkingModel.baseUrl + NetworkingModel.profile
        }
        
    }

    var id: String { return self.rawValue }
}
