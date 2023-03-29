//
//  RegistrationRequest.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 28.03.2023.
//

import Foundation

struct RegistrationRequest: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}
