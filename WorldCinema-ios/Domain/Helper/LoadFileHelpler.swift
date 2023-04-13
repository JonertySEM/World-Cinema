//
//  LoadFileHelpler.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//

import Foundation
import UIKit

class LoadFileHelper {
    static func loadImgeAvatar(withUrl url: URL, view: UIImageView) {
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        view.image = image
                        view.layer.cornerRadius = view.frame.size.width / 2
                        view.clipsToBounds = true
                    }
                }
            }
        }
    }
    
    static func loadImge(withUrl url: URL, view: UIImageView) {
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        view.image = image
                        view.clipsToBounds = true
                    }
                }
            }
        }
    }
}
