//
//  UIButtonExtension.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation
import UIKit

extension UIButton {
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(self.animateDown(sender:)), for: [.touchDown, .touchDragEnter, .touchUpInside])
        addTarget(self, action: #selector(self.animateUp(sender:)), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        self.animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        self.animate(sender, transform: .identity)
    }
    
    func buttonActive() {
        self.isEnabled = true
        self.changeButton(button: self, color: .red)
    }
    
    func buttonEnable() {
        self.isEnabled = false
        self.changeButton(button: self, color: .black)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                           button.transform = transform
                       }, completion: nil)
    }
    
    private func changeButton(button: UIButton, color: UIColor) {
        UIView.animate(withDuration: 1.0) {
            button.backgroundColor = color
        }
    }
}
