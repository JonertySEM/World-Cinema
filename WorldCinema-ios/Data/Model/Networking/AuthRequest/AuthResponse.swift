//
//  AuthResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 28.03.2023.
//

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let accessTokenExpiresIn: Int?
    let refreshToken: String
    let refreshTokenExpiresIn: Int?
}
