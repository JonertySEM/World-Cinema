//
//  DispatchQueueExtension.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//

import Foundation
extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    completion()
                }
            }
        }
    }
}
