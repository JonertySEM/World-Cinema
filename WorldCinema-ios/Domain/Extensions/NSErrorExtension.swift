//
//  NSErrorExtension.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 28.03.2023.
//

import Foundation

extension NSError {
    static func createErrorWithLocalizedDescription(_ text: String) -> NSError {
        NSError(
            domain: Bundle.main.bundleIdentifier ?? "com.hits.WorldCinema-ios",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: text]
        )
    }
}
