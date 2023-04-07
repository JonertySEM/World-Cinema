//
//  CoordinatorMainRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import UIKit

typealias CoordinatorHendler = () -> ()

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var flowCompletionHendler: CoordinatorHendler? { get set }
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
   
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func finish()
    
    init(_ navigationController: UINavigationController)
    
    
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

