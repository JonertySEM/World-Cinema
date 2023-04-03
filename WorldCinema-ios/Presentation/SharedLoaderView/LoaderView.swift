//
//  LoaderView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 02.04.2023.
//

import Foundation
import SwiftUI

final class LoaderView {
    static func startLoading(text: String = R.string.localizable.loading()) {
        DispatchQueue.main.async {
            SwiftLoader.show(title: text, animated: true)
        }
    }

    static func endLoading() {
        DispatchQueue.main.async {
            SwiftLoader.hide()
        }
    }
}
