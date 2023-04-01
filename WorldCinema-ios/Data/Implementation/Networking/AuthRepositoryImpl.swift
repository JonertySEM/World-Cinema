//
//  AuthRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 26.03.2023.
//

import Alamofire
import Foundation

class AuthRepositoryImpl: AuthorizationRepository {
    private static let url = NetworkingModel.baseUrl

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder, jsonEncoder: JSONEncoder) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func login(authorizationRequest: AuthorizationRequest,
               completion: ((Result<AuthResponse, Error>) -> Void)?)
    {
        do {
            let encodedParametrs = try jsonEncoder.encode(authorizationRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingModel.login,
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingModel.headers
            ) { $0.timeoutInterval = NetworkingModel.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func registration(registrationRequest: RegistrationRequest,
                      completion: ((Result<AuthResponse, Error>) -> Void)?)
    {
        do {
            let encodedParametrs = try jsonEncoder.encode(registrationRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingModel.registration,
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingModel.headers
            ) { $0.timeoutInterval = NetworkingModel.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }

    func updateRefreshToken(authorizationRequest: RefreshTokenRequest, completion: ((Result<AuthResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(authorizationRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingModel.refreshToken,
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetworkingModel.headers
            ) { $0.timeoutInterval = NetworkingModel.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }

        } catch {
            completion?(.failure(error))
        }
    }
}
