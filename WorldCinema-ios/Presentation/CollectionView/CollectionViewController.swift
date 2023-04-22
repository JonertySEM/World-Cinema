//
//  CollectionViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import UIKit

class CollectionViewController: UIViewController {
    var viewModel: CollectionViewModel
    
    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    
    private func createUI() {
        
    }
    
}
