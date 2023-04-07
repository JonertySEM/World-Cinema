//
//  ProfileComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import Foundation
import NeedleFoundation

protocol ProfileComponentDependency: Dependency {
    
}


final class ProfileComponent: Component <ProfileComponentDependency> {
    
    var profileViewController: ProfileViewController {
        return ProfileViewController()
    }
}
