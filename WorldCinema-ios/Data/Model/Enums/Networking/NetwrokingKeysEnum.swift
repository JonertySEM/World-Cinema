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
    case createCollection
    case getCompilationMovie
    case getLastViewMovie
    case getForMeMovie
    case getInTrendMovie
    case getNewMovie

    var rawValue: String {
        switch self {
        case .getCover:
            return NetworkingModel.baseUrl + NetworkingModel.coverLine

        case .getProfile:
            return NetworkingModel.baseUrl + NetworkingModel.profile

        case .createCollection:
            return NetworkingModel.baseUrl + NetworkingModel.collectionLine

        case .getCompilationMovie:
            return NetworkingModel.baseUrl + NetworkingModel.movieLine + "?filter=compilation"

        case .getLastViewMovie:
            return NetworkingModel.baseUrl + NetworkingModel.movieLine + "?filter=lastView"

        case .getForMeMovie:
            return NetworkingModel.baseUrl + NetworkingModel.movieLine + "?filter=forMe"

        case .getInTrendMovie:
            return NetworkingModel.baseUrl + NetworkingModel.movieLine + "?filter=inTrend"

        case .getNewMovie:
            return NetworkingModel.baseUrl + NetworkingModel.movieLine + "?filter=new"
        }
    }

    var id: String { return self.rawValue }
}
