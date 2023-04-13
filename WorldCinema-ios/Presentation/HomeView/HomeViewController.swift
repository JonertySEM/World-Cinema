//
//  HomeViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Combine
import SnapKit
import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    var viewModel: HomeViewModel
    private var subscribers: Set<AnyCancellable> = []
    
    private var refreshControl = UIRefreshControl()
    
    private var newMovieList = [MovieResponse]()
    private var inTrendMovieList = [MovieResponse]()
    private var lastWatchFilm  = MovieResponse(movieId: "",
                                              name: "",
                                              description: "",
                                              age: "",
                                              chatInfo: ChatInfoResponse(chatId: "",
                                                                    chatName: ""),
                                              imageUrls: [String](),
                                              poster: "",
                                              tags: [TagResponse]())
    private var forYouMovieList = [MovieResponse]()
    
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
        
        viewModel.getNewMovie()
        viewModel.getCoverInView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        viewModel.$isProgressProfileShowing.sink { [self] result in
            if result {
                createView()
                viewModel.isProgressProfileShowing = false
            }
        }.store(in: &subscribers)
        
        viewModel.$filmCover.sink { [self] url in
            guard let imageUrl = URL(string: url) else { return }
            LoadFileHelper.loadImge(withUrl: imageUrl, view: imagesCoverCard)
        }.store(in: &subscribers)
        
        viewModel.$movieNewList.sink { [self] list in
            newMovieList = list
        }.store(in: &subscribers)
        
        viewModel.$movieInTrend.sink { [self] list in
            inTrendMovieList = list
        }.store(in: &subscribers)
        
        viewModel.$lastWatchedMovie.sink { [self] movie in
            lastWatchFilm = movie
        }.store(in: &subscribers)
        
        viewModel.$movieForMeList.sink { [self] list in
            forYouMovieList = list
        }.store(in: &subscribers)
        
        scrollView.refreshControl = refreshControl
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .red
        scrollView.addSubview(refreshControl)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    let inTrendCollection = InTrendCollectionView()
    
    let filmsForYouCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionFilmsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionFilmsView.translatesAutoresizingMaskIntoConstraints = false
        return collectionFilmsView
    }()
    
    let imagesCoverCard: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var newFilmsCollectionView = MovieCollectionView(movieList: newMovieList)
    
    private func createView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let homeView = UIView()
        
        print("--------------MOVIELIST")
        print(newMovieList)
        
        let shadowSceneCard = R.image.shadow()
        
        let imagesShadowCard: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.layer.masksToBounds = true
            return image
        }()
        
        let tapWatchFilm: CustomButton = {
            let button = CustomButton()
            button.setTitle(R.string.localizable.watch(), for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = R.font.sfProTextBold(size: 15)
            button.backgroundColor = .red
            button.layer.cornerRadius = 4
            return button
        }()
        
        let tapYourFavorites: CustomButton = {
            let button = CustomButton()
            button.setTitle(R.string.localizable.addPrefers(), for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = R.font.sfProTextBold(size: 15)
            button.backgroundColor = .red
            button.layer.cornerRadius = 4
            return button
        }()
        
        let labelInTrend: UILabel = {
            let label = UILabel()
            label.text = R.string.localizable.inTrends()
            label.font = R.font.sfProTextBold(size: 24)
            label.textColor = .red
            return label
        }()
        
        let labelYouWatched: UILabel = {
            let label = UILabel()
            label.text = R.string.localizable.youWatched()
            label.font = R.font.sfProTextBold(size: 24)
            label.textColor = .red
            return label
        }()
        
        let labelNewFilms: UILabel = {
            let label = UILabel()
            label.text = R.string.localizable.newFilms()
            label.font = R.font.sfProTextBold(size: 24)
            label.textColor = .red
            return label
        }()
        
        let labelForYouFilms: UILabel = {
            let label = UILabel()
            label.text = R.string.localizable.forYou()
            label.font = R.font.sfProTextBold(size: 24)
            label.textColor = .red
            return label
        }()
        
        let filmWitchYouWatched: UIImageView = {
            let viewFilm = UIImageView()
            return viewFilm
        }()
        
        view.addSubview(scrollView)
       
        scrollView.addSubview(homeView)
        
        imagesShadowCard.image = shadowSceneCard
        
        homeView.addSubview(labelInTrend)
        homeView.addSubview(inTrendCollection)
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
        }
        
        inTrendCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelInTrend.snp.bottom).inset(-16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.22)
        }
        
        labelYouWatched.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.top.equalTo(imagesCoverCard.snp.bottom).inset(-32).priority(300)
            make.top.equalTo(inTrendCollection.snp.bottom).inset(-32)
        }
        
        filmWitchYouWatched.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelYouWatched.snp.bottom).inset(-16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.20)
        }
        
        labelNewFilms.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.top.equalTo(filmWitchYouWatched.snp.bottom).inset(-32)
        }
        
        newFilmsCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(labelNewFilms.snp.bottom).inset(-16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.18)
        }
        
        labelForYouFilms.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.top.equalTo(newFilmsCollectionView.snp.bottom).inset(-32)
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
        
//        labelInTrend.removeFromSuperview()
//        inTrendCollection.removeFromSuperview()
    }
     
    
    @objc func refresh() {
        viewModel.getNewMovie()
        
        viewModel.$isProgressProfileShowing.sink { [self] flag in
            if flag {
                newFilmsCollectionView.movieNewCollectionView.reloadData()
                refreshControl.endRefreshing()
                viewModel.isProgressProfileShowing = false
            }
        }.store(in: &subscribers)
    }
}
