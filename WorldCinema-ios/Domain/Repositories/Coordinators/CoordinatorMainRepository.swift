//
//  CoordinatorMainRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import UIKit

typealias CoordinatorHendler = () -> ()

protocol CoordinatorMainRepository: AnyObject {
    var navigationController: UINavigationController { get set }
    var flowCompletionHendler: CoordinatorHendler? { get set }
    
    func start()
}
