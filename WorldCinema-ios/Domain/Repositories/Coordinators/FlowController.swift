//
//  FlowController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation

protocol FlowController {
    associatedtype T
    associatedtype B
    var completionHandler: ((T) -> ())? { get set }
    var completionHandlerButton: ((B) -> ())? { get set }
}
