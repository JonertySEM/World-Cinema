//
//  ProfileResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 09.04.2023.
//

import Foundation

struct ProfileResponse: Codable {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    let avatar: String?
    
}
