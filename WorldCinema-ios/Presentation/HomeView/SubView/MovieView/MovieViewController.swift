//
//  MovieViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 14.04.2023.
//

import Combine
import UIKit

class MovieViewController: UIViewController {
    private var subscribers: Set<AnyCancellable> = []
    
    var viewModel: MovieViewModel
    private var filmData = MovieResponse()
    private var episodesData = [EpisodesResponse]()
    
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
        
        viewModel.getEpisodes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.$film.sink { [self] movie in
            filmData = movie
        }.store(in: &subscribers)
        
        
        viewModel.$film.sink { [self] url in
            guard let imageUrl = URL(string: url.poster) else { return }
            LoadFileHelper.loadImge(withUrl: imageUrl, view: imagesCoverCard)
        }.store(in: &subscribers)
        
        viewModel.$isProgressProfileShowing.sink { [self] flag in
            if flag {
                createFilmData()
            }
        }.store(in: &subscribers)
        
        viewModel.$episodes.sink { [self] episodes in
            episodesData = episodes
        }.store(in: &subscribers)
        
        yearLabel.text = filmData.age
        yearLabel.textColor = Year.getStatusRating(str: filmData.age)?.getColorRating()
        
        titleInfo.text = filmData.name
        textDescription.text = filmData.description
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
    
    let tapWatchFilm: CustomButton = {
        let button = CustomButton()
        button.setTitle(R.string.localizable.watch(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = R.font.sfProTextBold(size: 15)
        button.backgroundColor = GetHexColorHelper().hexStringToUIColor(hex: "#EF3A01")
        button.layer.cornerRadius = 4
        return button
    }()
    
    let homeView = UIView()
    
    let subInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.contentMode = .scaleToFill
        stack.spacing = 18
        stack.distribution = .fill
        return stack
        
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProTextBold(size: 17)
        return label
    }()
    
    let messageImage: UIImageView = {
        let image = UIImageView()
        image.image = R.image.messageMovieProfile()
        return image
    }()
    
    
    lazy var tagCollectionView = TagCollectionView(tagList: filmData.tags)
    lazy var filmCadrCollectionView = CadrPreviewCollectionView(filmPreview: filmData.imageUrls)
    lazy var episodePreviewCollectionView = EpisodePreviewCollectionView(episodeList: episodesData)
    
    let aboutFilmInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.contentMode = .scaleToFill
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    let titleInfo: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = R.font.sfProTextBold(size: 24)
        label.textColor = .white
        return label
    }()
    
    let textDescription: UILabel = {
        let textInfo = UILabel()
        textInfo.font = R.font.sfProTextRegular(size: 17)
        textInfo.numberOfLines = 0
        textInfo.textColor = .white
        return textInfo
    }()
    
    let cadrsInfo: UILabel = {
        let label = UILabel()
        label.text = "Кадры"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = R.font.sfProTextBold(size: 24)
        label.textColor = .white
        return label
    }()
    
    let episodeInfo: UILabel = {
        let label = UILabel()
        label.text = "Эпизоды"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = R.font.sfProTextBold(size: 24)
        label.textColor = .white
        return label
    }()
    
    private func createFilmData() {
        view.addSubview(scrollView)
       
        print("-------------Episode")
        print(episodesData)
        
        scrollView.addSubview(homeView)
        
        homeView.backgroundColor = .black
        
        imagesShadowCard.image = shadowSceneCard
        
        homeView.addSubview(imagesCoverCard)
        homeView.addSubview(imagesShadowCard)
        homeView.addSubview(tapWatchFilm)
        homeView.addSubview(tagCollectionView)
        
        homeView.addSubview(subInfoStack)
        subInfoStack.addArrangedSubview(yearLabel)
        subInfoStack.addArrangedSubview(messageImage)
        
        homeView.addSubview(aboutFilmInfoStack)
        aboutFilmInfoStack.addArrangedSubview(titleInfo)
        aboutFilmInfoStack.addArrangedSubview(textDescription)
        
        homeView.addSubview(cadrsInfo)
        homeView.addSubview(filmCadrCollectionView)
        
        homeView.addSubview(episodeInfo)
        homeView.addSubview(episodePreviewCollectionView)
        
        
        
        
        
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
        
        tapWatchFilm.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(120)
            make.trailing.equalTo(homeView.snp.trailing).inset(120)
            make.bottom.greaterThanOrEqualTo(imagesShadowCard.snp.bottom).inset(55)
            make.top.greaterThanOrEqualTo(homeView.snp.top).inset(210)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.05)
        }
        
        subInfoStack.snp.makeConstraints { make in
            make.trailing.equalTo(homeView.snp.trailing).inset(20)
            make.top.equalTo(imagesCoverCard.snp.bottom).inset(-20)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.026)
        }
        
        imagesCoverCard.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading)
            make.trailing.equalTo(homeView.snp.trailing)
            make.top.equalTo(homeView.snp.top)
            make.height.equalTo(imagesShadowCard.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.trailing.equalTo(homeView.snp.trailing).inset(66)
            make.top.equalTo(subInfoStack.snp.bottom).inset(-24)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.085)
        }
        
        aboutFilmInfoStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(tagCollectionView.snp.bottom).inset(-32)
        }
        
        cadrsInfo.snp.makeConstraints { make in
            make.top.equalTo(aboutFilmInfoStack.snp.bottom).inset(-32)
            make.leading.equalTo(homeView.snp.leading).inset(16)
        }
        
        filmCadrCollectionView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(cadrsInfo.snp.bottom).inset(-8)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.18)
        }
        
        episodeInfo.snp.makeConstraints { make in
            make.leading.equalTo(homeView.snp.leading).inset(16)
            make.top.equalTo(filmCadrCollectionView.snp.bottom).inset(-32)
        }
        
        episodePreviewCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(episodeInfo.snp.bottom).inset(-16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.25)
            make.bottom.equalTo(homeView.snp.bottom).inset(32)
        }
        
        if episodesData.count == 0 {
            episodeInfo.removeFromSuperview()
            episodePreviewCollectionView.removeFromSuperview()
        }
        
        
    }
}
