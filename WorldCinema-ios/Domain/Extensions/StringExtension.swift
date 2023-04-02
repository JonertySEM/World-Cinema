//
//  StringExtension.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation

extension String {
    var isEmptyTextField: Bool {
        self.isEmpty && self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
