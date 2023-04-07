//
//  CoordinatorCinemaRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Foundation
import UIKit

protocol CoordinatorCinemaRepository: AnyObject {
    
    var tabBarNavigationController: UITabBarController { get set }
    
    func start()
    
    func selectPage(_ page: TabBarEnum)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarEnum?
}
