//
//  UIImageView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          
          guard let imageData = data else { return }

          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
}
