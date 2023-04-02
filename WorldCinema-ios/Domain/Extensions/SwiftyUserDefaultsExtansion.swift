//
//  SwiftyUserDefaultsExtansion.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 02.04.2023.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var isAuthorized: DefaultsKey<Bool?> { .init("isAuthorized", defaultValue: false) }
}
