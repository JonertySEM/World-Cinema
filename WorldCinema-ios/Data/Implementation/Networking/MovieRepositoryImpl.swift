//
//  MovieRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Alamofire
import Foundation

class MovieRepositoryImpl: MovieRepository {
    private static let url = NetworkingModel.baseUrl
    
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    private let requestInterceptor: RequestInterceptor
    
    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder, requestInterceptor: RequestInterceptor) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.requestInterceptor = requestInterceptor
    }
    
    func getNewMovie(token: String, completion: ((Result<[MovieResponse], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.movieLine + "?filter=new",
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
    
    func getInTrendMovie(token: String, completion: ((Result<[MovieResponse], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.movieLine + "?filter=inTrend",
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
    
    func getForMeMovie(token: String, completion: ((Result<[MovieResponse], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.movieLine + "?filter=forMe",
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
    
    func getLastViewMovie(token: String, completion: ((Result<MovieResponse, Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.movieLine + "?filter=lastView",
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
    
    func getCompilationMovie(token: String, completion: ((Result<[MovieResponse], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.movieLine + "?filter=compilation",
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
