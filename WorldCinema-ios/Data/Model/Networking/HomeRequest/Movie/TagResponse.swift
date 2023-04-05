//
//  TagResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation

struct TagResponse: Codable {
    let tagId: String
    let tagName: String
    let categoryName: String
}
