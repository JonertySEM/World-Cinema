//
//  AuthorizationRequest.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 28.03.2023.
//

import Foundation

struct AuthorizationRequest: Codable {
    let email: String
    let password: String
}
