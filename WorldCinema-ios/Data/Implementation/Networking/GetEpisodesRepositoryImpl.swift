//
//  GetEpisodesRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Alamofire
import Foundation

class GetEpisodesRepositoryImpl: GetEpisodesRepository {
    private let requestInterceptor: RequestInterceptor

    private static let url = NetworkingModel.baseUrl

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder,
         jsonEncoder: JSONEncoder,
         requestInterceptor: RequestInterceptor)
    {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.requestInterceptor = requestInterceptor
    }

    func getEpisodes(token: String, filmId: String, completion: ((Result<[EpisodesResponse], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.movieLine + "/\(filmId)" + NetworkingModel.episodes,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token),
            interceptor: requestInterceptor
        ) { $0.timeoutInterval = NetworkingModel.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
}
