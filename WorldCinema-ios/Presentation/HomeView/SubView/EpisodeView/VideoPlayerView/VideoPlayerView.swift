//
//  VideoPlayerView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 19.04.2023.
//


import AVKit
import Foundation
import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    let fileUrl: String
    let avpController: AVPlayerViewController
    var player: AVPlayer!
    
    
    var isVideoPlaying = false
    
    let indicatorLoadingVideoView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.color = .red
        indicator.startAnimating()
        return indicator
    }()
   
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    var timeSlider: UISlider = {
       let slider = UISlider()
        slider.isContinuous = false
        slider.tintColor = .red
        return slider
    }()

    
    let startButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(tapToStartButton), for: .touchUpInside)
        return button
    }()
    
    init(
        fileUrl: String,
        avpController: AVPlayerViewController
    ) {
        self.fileUrl = fileUrl
        self.avpController = avpController
        super.init(frame: .zero)
       
        addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainView.addSubview(avpController.view)
        mainView.addSubview(indicatorLoadingVideoView)
        
        mainView.addSubview(startButton)
        mainView.addSubview(timeSlider)
        timeSlider.minimumValue = 0
               
               
        
        
        startButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(mainView)
        }
        
        indicatorLoadingVideoView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(mainView)
        }
        
        avpController.view.snp.makeConstraints { make in
            make.edges.equalTo(mainView)
        }
        
        timeSlider.snp.makeConstraints({ make in
            make.leading.trailing.equalTo(mainView).inset(60)
            make.bottom.equalTo(mainView.snp.bottom).inset(10)
        })
        
        addPlayerView(fileUrl: fileUrl, avpController: avpController)
        
        
       
       
               
        timeSlider.addTarget(self, action: #selector(self.playbackSliderValueChanged(_:)), for: .valueChanged)
       
        
        guard let url = URL(string: fileUrl) else { return }
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        timeSlider.maximumValue = Float(seconds)
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
       {
           
           let seconds : Int64 = Int64(playbackSlider.value)
           let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
           
           player!.seek(to: targetTime)
           
           if player!.rate == 0
           {
               player?.play()
           }
       }
    
    @objc func tapToStartButton() {
        if !isVideoPlaying {
            player?.play()
            startButton.setImage(UIImage(named: "videoStartButton"), for: .normal)
        } else {
            player?.pause()
            startButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }

        isVideoPlaying = !isVideoPlaying
    }
    
    
    private func addPlayerView(fileUrl: String, avpController: AVPlayerViewController) {
        guard let url = URL(string: fileUrl) else { return }
        
        DispatchQueue.main.async { [self] in
            player = AVPlayer(url: url)
            
            avpController.player = player
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            indicatorLoadingVideoView.stopAnimating()
            startButton.isHidden = false
            mainView.backgroundColor = .clear
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
