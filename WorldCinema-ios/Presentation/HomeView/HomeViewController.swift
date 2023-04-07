//
//  HomeViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import SnapKit
import UIKit

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
        
        createView()
        viewModel.getCoverInView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func createView() {
        let scrollView = UIScrollView()
        let homeView = UIView()
        
        let coverSceneCard = UIImage(named: "cover")
        let shadowSceneCard = UIImage(named: "shadow")
        let imagesCoverCard = UIImageView()
        let imagesShadowCard = UIImageView()
        
        let tapWatchFilm: CustomButton = {
            let button = CustomButton()
            button.setTitle("Смотреть", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = R.font.sfProTextBold(size: 15)
            button.backgroundColor = .red
            button.layer.cornerRadius = 4
            return button
        }()
        
        let tapYourFavorites: CustomButton = {
            let button = CustomButton()
            button.setTitle("Указать интересы", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = R.font.sfProTextBold(size: 15)
            button.backgroundColor = .red
            button.layer.cornerRadius = 4
            return button
        }()
        
        let labelInTrend: UILabel = {
            let label = UILabel()
            label.text = "В тренде"
            label.font = R.font.sfProTextBold(size: 24)
            label.textColor = .red
            return label
        }()
        
        let labelYouWatched: UILabel = {
            let label = UILabel()
            label.text = "Вы смотрели"
            label.font = R.font.sfProTextBold(size: 24)
            label.textColor = .red
            return label
        }()
        
        let labelNewFilms: UILabel = {
            let label = UILabel()
            label.text = "Новое"
            label.font = R.font.sfProTextBold(size: 24)
            label.textColor = .red
            return label
        }()
        
        let labelForYouFilms: UILabel = {
            let label = UILabel()
            label.text = "Для вас"
            label.font = R.font.sfProTextBold(size: 24)
            label.textColor = .red
            return label
        }()
        
        let filmWitchYouWatched: UIImageView = {
            let viewFilm = UIImageView()
            return viewFilm
        }()
        
        let trendCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionFilmsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionFilmsView.translatesAutoresizingMaskIntoConstraints = false
            return collectionFilmsView
        }()
        
        let newFilmsCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionFilmsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionFilmsView.translatesAutoresizingMaskIntoConstraints = false
            return collectionFilmsView
        }()
        
        let filmsForYouCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionFilmsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionFilmsView.translatesAutoresizingMaskIntoConstraints = false
            return collectionFilmsView
        }()
        
        view.addSubview(scrollView)
        scrollView.addSubview(homeView)
        
        imagesShadowCard.image = shadowSceneCard
        imagesCoverCard.image = coverSceneCard
        
        homeView.addSubview(imagesShadowCard)
       
        homeView.addSubview(labelInTrend)
        homeView.addSubview(trendCollectionView)
        homeView.addSubview(labelYouWatched)
        homeView.addSubview(filmWitchYouWatched)
        homeView.addSubview(labelNewFilms)
        homeView.addSubview(newFilmsCollectionView)
        homeView.addSubview(labelForYouFilms)
        homeView.addSubview(filmsForYouCollectionView)
        homeView.addSubview(tapYourFavorites)
        homeView.addSubview(imagesCoverCard)
        homeView.addSubview(imagesShadowCard)
        homeView.addSubview(tapWatchFilm)
        
        homeView.backgroundColor = .black
        
        filmWitchYouWatched.backgroundColor = .green
        
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
            make.height.greaterThanOrEqualTo(super.view.snp.height).multipliedBy(1.75)
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
            make.height.greaterThanOrEqualTo(super.view.snp.height).multipliedBy(0.5)
        }
        
        tapWatchFilm.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(120)
            make.trailing.equalTo(homeView.snp.trailing).inset(120)
            make.bottom.greaterThanOrEqualTo(imagesShadowCard.snp.bottom).inset(55)
            make.top.greaterThanOrEqualTo(homeView.snp.top).inset(210)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.05)
        }
        
        labelInTrend.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.top.equalTo(imagesShadowCard.snp.bottom).inset(-32)
            make.trailing.equalTo(homeView.snp.trailing).inset(247)
        }
        
        trendCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelInTrend.snp.bottom).inset(-16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.22)
        }
        
        labelYouWatched.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.top.equalTo(trendCollectionView.snp.bottom).inset(-32)
            make.trailing.equalTo(homeView.snp.trailing).inset(196)
        }
        
        filmWitchYouWatched.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelYouWatched.snp.bottom).inset(-16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.20)
        }
        
        labelNewFilms.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.top.equalTo(filmWitchYouWatched.snp.bottom).inset(-32)
            make.trailing.equalTo(homeView.snp.trailing).inset(282)
        }
        
        newFilmsCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelNewFilms.snp.bottom).inset(-16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.18)
        }
        
        labelForYouFilms.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.top.equalTo(newFilmsCollectionView.snp.bottom).inset(-32)
            make.trailing.equalTo(homeView.snp.trailing).inset(262)
        }
        
        filmsForYouCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelForYouFilms.snp.bottom).inset(-16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.22)
        }
        
        tapYourFavorites.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.trailing.equalTo(homeView.snp.trailing).inset(16)
            make.bottom.lessThanOrEqualTo(homeView.snp.bottom).inset(20)
            make.top.equalTo(filmsForYouCollectionView.snp.bottom).inset(-44)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.05)
        }
    }
}
