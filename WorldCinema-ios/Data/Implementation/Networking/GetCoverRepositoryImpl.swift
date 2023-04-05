//
//  GetCoverRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Alamofire
import Foundation

class GetCoverRepositoryImpl: GetHomeCoverRepository {
    private static let url = NetworkingModel.baseUrl
    
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    
    private let requestInterceptor: RequestInterceptor
    
    init(jsonDecoder: JSONDecoder,
         jsonEncoder: JSONEncoder,
         requestInterceptor: RequestInterceptor) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.requestInterceptor = requestInterceptor
    }
    
    func getCover(token: String,
                  completion: ((Result<CoverResponse, Error>) -> Void)?)
    {
        AF.request(
            Self.url + NetworkingModel.coverLine,
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
