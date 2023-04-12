//
//  NetworkingModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 28.03.2023.
//

import Alamofire
import Foundation

class NetworkingModel {
    static let baseUrl = "http://107684.web.hosting-russia.ru:8000/api"

    static let login = "/auth/login"
    static let registration = "/auth/register"
    static let refreshToken = "/auth/refresh"
    static let coverLine = "/cover"
    static let movieLine = "/movies"
    static let collectionLine = "/collections"
    static let profile = "/profile"
    static let avatar = "/avatar"

    static let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "accept": "*/*"
    ]

    static let wrongDataStatusCode = 401
    static let unauthorizedStatusCode = 401
    static let wrongAccessToken = 450
    static let unacceptableStatusCode = 404
    static let wrongRefreshToken = 451
    static let wrongEmailValidationErrorStatusCode = 409
    static let userAlreadyExistsStatusCode = 400
    static let successStatusCode = 200

    static let timeout = TimeInterval(10)
}
