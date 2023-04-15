//
//  MovieViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 14.04.2023.
//

import UIKit
import Combine

class MovieViewController: UIViewController {
    
    private var subscribers: Set<AnyCancellable> = []
    
    var viewModel: MovieViewModel
    private var filmData = MovieResponse()
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.$film.sink { [self] movie in
            filmData = movie
            createFilmData()
        }.store(in: &subscribers)
        
        viewModel.$film.sink { [self] url in
            guard let imageUrl = URL(string: url.poster) else { return }
            LoadFileHelper.loadImge(withUrl: imageUrl, view: imagesCoverCard)
        }.store(in: &subscribers)
    }
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.backgroundColor = GetHexColorHelper().hexStringToUIColor(hex: "#150D0B")
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    let imagesCoverCard: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    let shadowSceneCard = R.image.shadow()
    
    let imagesShadowCard: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    let homeView = UIView()
    
    private func createFilmData() {
        view.addSubview(scrollView)
       
        scrollView.addSubview(homeView)
        
        homeView.backgroundColor = GetHexColorHelper().hexStringToUIColor(hex: "#150D0B")
        
        imagesShadowCard.image = shadowSceneCard
        
        homeView.addSubview(imagesCoverCard)
        homeView.addSubview(imagesShadowCard)
        
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(super.view.snp.bottom)
            make.top.equalTo(super.view.snp.top)
            make.height.equalTo(super.view.snp.height)
        }
        
        homeView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(super.view.snp.width)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        imagesShadowCard.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading)
            make.trailing.equalTo(homeView.snp.trailing)
            make.top.equalTo(homeView.snp.top)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.5)
        }
        
        imagesCoverCard.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading)
            make.trailing.equalTo(homeView.snp.trailing)
            make.top.equalTo(homeView.snp.top)
            make.height.equalTo(imagesShadowCard.snp.height).multipliedBy(1.0 / 1.0)
        }
    }
    


}
