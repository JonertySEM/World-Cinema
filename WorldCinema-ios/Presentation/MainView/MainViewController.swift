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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        
        let testLabel: UILabel = {
            let label = UILabel()
            label.text = "Test"
            return label
        }()
        
        view.backgroundColor = .black
        view.addSubview(testLabel)
    }
}
