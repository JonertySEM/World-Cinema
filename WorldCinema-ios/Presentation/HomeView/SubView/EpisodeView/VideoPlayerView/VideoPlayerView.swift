//
//  VideoPlayerView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 19.04.2023.
//

import AVFoundation
import AVKit
import Foundation
import UIKit

class VideoPlayerView: UIView {
    private let fileUrl: String
    private let avpController: AVPlayerViewController
    var player: AVPlayer!
    
    private var isVideoPlaying = false
    private var isAudioPlaying = false
    
    private var indicatorLoadingVideoView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.color = .red
        indicator.startAnimating()
        return indicator
    }()
   
    private var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(tapToStartButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var videoSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 10, y: 300, width: 300, height: 10))
        slider.setThumbImage(UIImage(named: "sliderBall"), for: .normal)
        slider.minimumValue = 0
        slider.isContinuous = true
        slider.isHidden = true
        slider.thumbTintColor = .red
        slider.tintColor = .red
        return slider
    }()
    
    private var curentTime: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProTextBold(size: 12)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private var duratationTime: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProTextBold(size: 12)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var volumeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(tapToOffVolumeButton), for: .touchUpInside)
        return button
    }()
    
    init(
        fileUrl: String,
        avpController: AVPlayerViewController
    ) {
        self.fileUrl = fileUrl
        self.avpController = avpController
        super.init(frame: .zero)
        avpController.showsPlaybackControls = false
        addSubview(mainView)
        mainView.addSubview(avpController.view)
        mainView.addSubview(indicatorLoadingVideoView)
        mainView.addSubview(volumeButton)
        mainView.addSubview(startButton)
        mainView.addSubview(videoSlider)
        mainView.addSubview(curentTime)
        mainView.addSubview(duratationTime)
        
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
        startButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(mainView)
        }
        
        indicatorLoadingVideoView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(mainView)
        }
        
        avpController.view.snp.makeConstraints { make in
            make.edges.equalTo(mainView)
        }
        
        loadingPlayerView(fileUrl: fileUrl, avpController: avpController)
        
        videoSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        
        videoSlider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(65)
            make.bottom.equalToSuperview().inset(10)
        }
        
        curentTime.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(videoSlider.snp.leading).inset(-10)
            make.bottom.equalToSuperview().inset(20)
        }
        
        duratationTime.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(videoSlider.snp.trailing).inset(-10)
            make.bottom.equalToSuperview().inset(20)
        }
        
        volumeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(40)
        }
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider: UISlider) {
        let seconds = Int64(playbackSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
           
        player!.seek(to: targetTime)
           
        if player!.rate == 0 {
            player?.play()
        }
    }
    
    @objc func tapToStartButton() {
       
        if !isVideoPlaying {
            player?.play()
            startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
        } else {
            player?.pause()
            startButton.setImage(UIImage(named: "videoStartButton"), for: .normal)
        }

        isVideoPlaying = !isVideoPlaying
    }
    
    @objc func tapToOffVolumeButton() {
        print("test")
        if !isAudioPlaying {
            player?.isMuted = true
            volumeButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
            
        } else {
            player?.isMuted = false
            volumeButton.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        }

        isAudioPlaying = !isAudioPlaying
    }
    
    private func loadingPlayerView(fileUrl: String, avpController: AVPlayerViewController) {
        guard let url = URL(string: fileUrl) else { return }
        
        DispatchQueue.main.async { [self] in
            player = AVPlayer(url: url)
            let timeScale = CMTimeScale(NSEC_PER_SEC)
            let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
            avpController.player = player
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 2, preferredTimescale: 1000), queue: .main, using: { _ in
                self.bufferState()
            })
            player?.addPeriodicTimeObserver(forInterval: time, queue: .main, using: { [weak self] time in
                self?.updateTime()
            })
            let duratation: CMTime = AVPlayerItem(url: url).asset.duration
            let seconds: Float64 = CMTimeGetSeconds(duratation)
            videoSlider.maximumValue = Float(seconds)
            
            
        }
    }
    
    private func bufferState() {
        
        if let currentItem = player.currentItem {
            if currentItem.isPlaybackBufferFull {
                print("buffer is full")
                player.automaticallyWaitsToMinimizeStalling = true
                player.currentItem?.preferredForwardBufferDuration = TimeInterval(5)
                player.currentItem?.cancelPendingSeeks()
                player.currentItem?.asset.cancelLoading()
            }
            if currentItem.status == AVPlayerItem.Status.readyToPlay {
                if currentItem.isPlaybackLikelyToKeepUp {
                } else if currentItem.isPlaybackBufferEmpty {
                    
                } else if currentItem.isPlaybackBufferFull {
                    print("buffer is all")
                    player.currentItem?.cancelPendingSeeks()
                    player.currentItem?.asset.cancelLoading()
                } else {
                    // Buffering
                }
            } else if currentItem.status == AVPlayerItem.Status.failed {
                print("Faile :( ")
            } else if currentItem.status == AVPlayerItem.Status.unknown {
                print("Problem")
            }
        } else {
            // Main error
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            indicatorLoadingVideoView.stopAnimating()
            startButton.isHidden = false
            videoSlider.isHidden = false
            volumeButton.isHidden = false
            mainView.backgroundColor = .clear
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getHoursMinutesSecondsFrom(seconds: Float64) -> (hours: Int, minutes: Int, seconds: Int) {
        let secs = Int(seconds)
        let hours = secs / 3600
        let minutes = (secs % 3600) / 60
        let seconds = (secs % 3600) % 60
        return (hours, minutes, seconds)
    }
    
    func updateTime() {
        if let currentItem = player.currentItem {
            let playhead = currentItem.currentTime().seconds
            let duration = currentItem.duration.seconds
            curentTime.text = toDisplayString(rawSeconds: playhead)
            duratationTime.text = toDisplayString(rawSeconds: duration)
        }
    }
    
    func toDisplayString(rawSeconds: Double) -> String {
        guard !(rawSeconds.isNaN || rawSeconds.isInfinite) else {
            return "--"
        }
        let totalSeconds = Int(rawSeconds)
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
}
