//
//  TabBarEnums.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import Foundation
import UIKit

enum TabBarEnum {
    case homeView
    case compilationView
    case collectionView
    case profileView
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .homeView
        case 1:
            self = .compilationView
        case 2:
            self = .collectionView
        case 3:
            self = .profileView
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .homeView:
            return R.string.localizable.homePage()
        case .compilationView:
            return R.string.localizable.compilation()
        case .collectionView:
            return R.string.localizable.collectionPage()
        case .profileView:
            return R.string.localizable.profile()
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .homeView:
            return 0
        case .compilationView:
            return 1
        case .collectionView:
            return 2
        case .profileView:
            return 3
        }
    }
    
    func addIconInTabBar() -> UIImage {
        switch self {
        case .homeView:
            guard let image = UIImage(named: "tiviMovie") else { return UIImage() }
            return image
        case .compilationView:
            guard let image = UIImage(named: "stackMovie") else { return UIImage() }
            return image
        case .collectionView:
            guard let image = UIImage(systemName: "star") else { return UIImage() }
            return image
        case .profileView:
            guard let image = UIImage(systemName: "person") else { return UIImage() }
            return image
        }
    }
    
    func changeStateButton(pressedButton: Bool) -> UIColor {
        return pressedButton ? .red : .gray
    }
}
