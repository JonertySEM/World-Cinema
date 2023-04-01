//
//  ViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 26.03.2023.
//

import Foundation
import SwiftUI
import UIKit

extension UIViewController {
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(viewController: self)
    }

    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
//        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
//            self.view.addSubview(child.view)
//        }, completion: nil)
    }
    
    func remove(content: UIViewController) {
        content.willMove(toParent: nil)
        
        
        UIView.animate(withDuration: 2.0) {
//            content.view.removeFromSuperview()
            content.view.alpha = 0
            
        }
        
//
//        UIView.transition(with: self.view, duration: 0.5, options: .overrideInheritedCurve, animations: {
//            content.view.removeFromSuperview()
//        }, completion: nil)
//        content.view.removeFromSuperview()
//        content.removeFromParent()
        
        
    }
}
