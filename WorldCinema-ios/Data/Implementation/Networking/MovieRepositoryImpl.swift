//
//  MovieRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation
import Alamofire

class MovieRepositoryImpl: MovieRepository {
    
    
    private static let url = NetworkingModel.baseUrl
    
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    
    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }
    
    func getNewMovie(token: String, completion: ((Result<MovieResponse, Error>) -> Void)?) {
        let parametr: Parameters = [
            "filter": "new"
        
        ]
        AF.request(
            Self.url + NetworkingModel.movieLine,
            method: .get,
            parameters: parametr,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingModel.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
    
    func getInTrendMovie(token: String, completion: ((Result<MovieResponse, Error>) -> Void)?) {
        let parametr: Parameters = [
            "filter": "inTrend"
        
        ]
        AF.request(
            Self.url + NetworkingModel.movieLine,
            method: .get,
            parameters: parametr,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingModel.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
    
    func getForMeMovie(token: String, completion: ((Result<MovieResponse, Error>) -> Void)?) {
        let parametr: Parameters = [
            "filter": "forMe"
        
        ]
        AF.request(
            Self.url + NetworkingModel.movieLine,
            method: .get,
            parameters: parametr,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token)
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
        let parametr: Parameters = [
            "filter": "lastView"
        
        ]
        AF.request(
            Self.url + NetworkingModel.movieLine,
            method: .get,
            parameters: parametr,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingModel.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
    
    func getCompilationMovie(token: String, completion: ((Result<MovieResponse, Error>) -> Void)?) {
        let parametr: Parameters = [
            "filter": "compilation"
        
        ]
        AF.request(
            Self.url + NetworkingModel.movieLine,
            method: .get,
            parameters: parametr,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token)
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
