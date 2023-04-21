//
//  GetHistoryFilmRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 21.04.2023.
//

import Alamofire
import Foundation

class GetHistoryFilmRepositoryImpl: GetHistoryFilmRepository {
    private static let url = NetworkingModel.baseUrl
    private let requestInterceptor: RequestInterceptor

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

    func getHistory(token: String, completion: ((Result<[HistoryRepsonse?], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.history,
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
