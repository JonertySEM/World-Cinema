//
//  MainViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 21.03.2023.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    private var viewModel: MainViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginViewController = MainComponent().loginComponent.loginViewController
        addChild(loginViewController)
        view.addSubview(loginViewController.view)
        loginViewController.didMove(toParent: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

