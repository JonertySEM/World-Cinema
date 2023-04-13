//
//  CollectionRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 07.04.2023.
//

import Alamofire
import Foundation

class CollectionRepositoryImpl: CollectionRepository {
    private static let url = NetworkingModel.baseUrl

    private let requestInterceptor: RequestInterceptor
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder, requestInterceptor: RequestInterceptor) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.requestInterceptor = requestInterceptor
    }

    func getAllCollection(token: String, completion: ((Result<[CollectionResponse], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.collectionLine,
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

    func createCollection(token: String, name: String, completion: ((Result<CollectionResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(name)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingModel.collectionLine,
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token),
                interceptor: requestInterceptor
            ) { $0.timeoutInterval = NetworkingModel.timeout }
                .validate()
                .response { [self] result in
                    print(result)
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func deleteCollection(token: String, collectionId: String, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.collectionLine + "/\(collectionId)",
            method: .delete,
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

    func getMoviesInCollection(token: String, collectionId: String, completion: ((Result<[MovieResponse], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.collectionLine + "/\(collectionId)" + "/movies",
            method: .delete,
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

    func addMovieInCollection(token: String, collectionId: String, movieId: String, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(movieId)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingModel.collectionLine + "/\(collectionId)" + "/movies",
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token),
                interceptor: requestInterceptor
            ) { $0.timeoutInterval = NetworkingModel.timeout }
                .validate()
                .response { [self] result in
                    print(result)
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func dislikeMovie(token: String, movieId: String, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(movieId)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingModel.movieLine + "/\(movieId)" + "/dislike",
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token),
                interceptor: requestInterceptor
            ) { $0.timeoutInterval = NetworkingModel.timeout }
                .validate()
                .response { [self] result in
                    print(result)
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func deleteMovieInCollection(token: String, collectionId: String, movieId: String, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        let parametr: Parameters = [
            "movieId": "\(movieId)"
        ]

        AF.request(
            Self.url + NetworkingModel.collectionLine + "/\(collectionId)" + "/movies",
            method: .delete,
            parameters: parametr,
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
