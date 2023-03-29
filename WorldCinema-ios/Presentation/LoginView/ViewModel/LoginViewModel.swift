//
//  LoginViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 28.03.2023.
//

import Foundation

class LoginViewModel {
    private var displayingViewMode = LoginViewDisplayingMode.authorization
    
    
    func updateDisplayMode(){
        switch displayingViewMode {
        case .authorization:
            displayingViewMode = .registration
        case .registration:
            displayingViewMode = .authorization
        }
    }
    
    var updatedViewMode: LoginViewDisplayingMode {
        return displayingViewMode
    }
    
}
