//
//  UIButtonExtension.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation
import UIKit

extension UIButton {
    func buttonActive() {
        self.isEnabled = true
        self.changeButton(button: self,
                color: GetHexColorHelper().hexStringToUIColor(hex: "#EF3A01"))
    }

    func buttonEnable() {
        self.isEnabled = false
        self.changeButton(button: self, color: GetHexColorHelper().hexStringToUIColor(hex: "#150D0B"))
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
    }

    private func changeButton(button: UIButton, color: UIColor) {
        UIView.animate(withDuration: 1.0) {
            button.backgroundColor = color
        }
    }
}
