//
//  EpisodeViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 18.04.2023.
//

import AVFoundation
import AVKit
import Combine
import SnapKit
import UIKit

class EpisodeViewController: UIViewController {
    private var subscribers: Set<AnyCancellable> = []
    
    let avPlayerController = AVPlayerViewController()

    var viewModel: EpisodeViewModel
    
    init(viewModel: EpisodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = .black
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        episodeTitle.text = viewModel.episode.name
        
        guard let imageUrl = URL(string: viewModel.film.poster) else { return }
        LoadFileHelper.loadImge(withUrl: imageUrl, view: pictureMovieInStack)
        
        labelOfNameMovie.text = viewModel.film.name
        labelOfCountSeasons.text = "\(viewModel.countEpisode) Серий"
        
        if viewModel.episode.year == nil {
            labelOfYearData.text = "2003"
        } else {
            guard let year = viewModel.episode.year else { return }
            labelOfYearData.text = String(year)
        }
        
        if viewModel.episode.description.isEmpty {
            descriptionText.text = viewModel.film.description
        } else {
            descriptionText.text = viewModel.episode.description
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            videoView.player.pause()
            let curTime = videoView.player.currentTime().seconds
            guard !(curTime.isNaN || curTime.isInfinite) else { return }
            viewModel.saveTimeEpisode(timeRequest: Int(curTime))
        }
    }

    lazy var videoView = VideoPlayerView(fileUrl: viewModel.episode.filePath, avpController: avPlayerController)
    
    let testVideoView: UIView = {
        let view = UIView()
        return view
    }()
    
    let episodeTitle: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.font = R.font.sfProTextBold(size: 24)
        label.textColor = .white
        return label
    }()
    
    let dataOfMovie: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        stack.distribution = .fill
        return stack
    }()
    
    let pictureMovieInStack: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    let textInfoOfMovie: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        stack.contentMode = .scaleToFill
        stack.distribution = .fill
        return stack
    }()
    
    let labelOfNameMovie: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.setContentHuggingPriority(.init(Float(251)), for: .vertical)
        label.font = R.font.sfProTextBold(size: 12)
        label.textColor = .white
        return label
    }()
    
    let labelOfCountSeasons: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.font = R.font.sfProTextBold(size: 12)
        label.setContentHuggingPriority(.init(Float(251)), for: .vertical)
        label.textColor = GetHexColorHelper().hexStringToUIColor(hex: "#AFAFAF")
        return label
    }()
    
    let labelOfYearData: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.font = R.font.sfProTextBold(size: 12)
        label.setContentHuggingPriority(.init(Float(250)), for: .vertical)
        label.textColor = GetHexColorHelper().hexStringToUIColor(hex: "#AFAFAF")
        return label
    }()
    
    let stackOfButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 22
        stack.contentMode = .scaleToFill
        stack.distribution = .fill
        return stack
    }()
    
    let messageMovieButton: UIImageView = {
        let view = UIImageView()
        view.image = R.image.messageMovieProfile()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let addInFavorite: UIImageView = {
        let view = UIImageView()
        view.image = R.image.plusMovie()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let addInChousenOne: UIImageView = {
        let view = UIImageView()
        view.image = R.image.heartMovie()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let descriptionTitleText: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.font = R.font.sfProTextBold(size: 24)
        label.textColor = .white
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProTextBold(size: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private func createUI() {
        view.addSubview(testVideoView)
        view.addSubview(episodeTitle)
        
        view.addSubview(dataOfMovie)
        
        dataOfMovie.addArrangedSubview(pictureMovieInStack)
        dataOfMovie.addArrangedSubview(textInfoOfMovie)
        textInfoOfMovie.addArrangedSubview(labelOfNameMovie)
        textInfoOfMovie.addArrangedSubview(labelOfCountSeasons)
        textInfoOfMovie.addArrangedSubview(labelOfYearData)
        
        view.addSubview(stackOfButtons)
        stackOfButtons.addArrangedSubview(messageMovieButton)
        stackOfButtons.addArrangedSubview(addInFavorite)
        stackOfButtons.addArrangedSubview(addInChousenOne)
        
        view.addSubview(descriptionTitleText)
        view.addSubview(descriptionText)
        
        testVideoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(48)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.253)
        }
        
        testVideoView.addSubview(videoView)
        videoView.snp.makeConstraints { make in
            make.edges.equalTo(testVideoView)
        }
        
        episodeTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(72)
            make.top.equalTo(testVideoView.snp.bottom).inset(-16)
        }
        
        pictureMovieInStack.snp.makeConstraints { make in
            make.width.equalTo(super.view.snp.width).multipliedBy(0.117)
        }
        
        dataOfMovie.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.08)
            make.trailing.equalTo(stackOfButtons.snp.leading).inset(-20)
            make.top.equalTo(episodeTitle.snp.bottom).inset(-16)
        }
        
        stackOfButtons.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18)
            make.top.equalTo(episodeTitle.snp.bottom).inset(-38)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.026)
        }
        
        descriptionTitleText.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.greaterThanOrEqualToSuperview()
            make.top.equalTo(dataOfMovie.snp.bottom).inset(-32)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(descriptionTitleText.snp.bottom).inset(-8)
        }
    }
}
