//
//  HomeViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.getCoverInView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    private func createView() {
        
        var scrollView = UIScrollView()
        var homeView = UIView()
        
        var cinemaCard = UIImage()
        var perimetrSceneCard = UIImage()
        var imagesCard = UIImageView()
        
        
        view.addSubview(scrollView)
        
        imagesCard.image = cinemaCard
        
        homeView.addSubview(imagesCard)
        
        
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.leading.equalTo(super.view.snp.leading)
            make.bottom.top.equalTo(super.view.snp.bottom)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.7)
        }
        
        homeView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(super.view.snp.width)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            //make.height.equalTo(super.view.snp.height).multipliedBy(0.68).inset(-20)
        }
        
        
        
    }
}
