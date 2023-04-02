//
//  UITextFieldExtension.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 02.04.2023.
//

import Foundation
import Combine
import UIKit

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
            NotificationCenter.default.publisher(
                for: UITextField.textDidChangeNotification,
                object: self
            )
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
        }
}
