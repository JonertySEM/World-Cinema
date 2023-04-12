//
//  UIViewExtension.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 10.04.2023.
//

import Foundation
import UIKit

extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                           self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       }) { _ in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                               self?.transform = CGAffineTransform(scaleX: 1, y: 1)
                           }) { [weak self] _ in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}
