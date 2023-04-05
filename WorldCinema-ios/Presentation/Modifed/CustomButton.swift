//
//  CustomButton.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 05.04.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateUp()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateDown()
    }
    

        
         private func animateDown() {
             UIView.animate(withDuration: 0.4,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 3,
                            options: [.allowUserInteraction,.curveEaseInOut],
                            animations: {
                                self.transform = .identity
                            }, completion: nil)
            
        }
        
         private func animateUp() {
             UIView.animate(withDuration: 0.4,
                            delay: 0,
                            usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 3,
                            options: [.allowUserInteraction, .curveEaseIn],
                            animations: {
                            self.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
                            }, completion: nil)
            
        }
    
    
    private func animate(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                           self.transform = transform
                       }, completion: nil)
    }
    
}
