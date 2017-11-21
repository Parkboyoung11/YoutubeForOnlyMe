//
//  VideoLauncher.swift
//  YoutubeOnlyForMe
//
//  Created by VuHongSon on 11/21/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player : AVPlayer?
    var isPlaying = false
    var lockShowPauseButton = true
    
    let activityIndicatorView : UIActivityIndicatorView = {
        let avt = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        avt.translatesAutoresizingMaskIntoConstraints = false
        avt.startAnimating()
        return avt
    }()
    
    let controlsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
//        view.isUserInteractionEnabled = true
        return view
    }()

    let pausePlayButton : UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "pause"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(handlePause), for: UIControlEvents.touchUpInside)
        button.tintColor = UIColor.white
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let videoLengthLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    let videoSlider : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumTrackTintColor = UIColor.white
        slider.minimumTrackTintColor = UIColor.red
        slider.setThumbImage(#imageLiteral(resourceName: "thumb"), for: UIControlState.normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: UIControlEvents.valueChanged)
        return slider
    }()
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    func handleSliderChange() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                //perhaps do something later here
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView()
        setupGradientLayer()
        
        self.addSubview(controlsContainerView)
        controlsContainerView.frame = frame
        controlsContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePause)))
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: controlsContainerView.rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: controlsContainerView.leftAnchor, constant: -2).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 4).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        

        backgroundColor = UIColor.black
    }
    
    func handlePause() {
        if isPlaying == true {
            pausePlayButton.setImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
            pausePlayButton.isHidden = false
            player?.pause()
        }else {
            pausePlayButton.setImage(#imageLiteral(resourceName: "pause"), for: UIControlState.normal)
            pausePlayButton.isHidden = false
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (time) in
                self.pausePlayButton.isHidden = true
            }
            player?.play()
        }
        
        isPlaying = !isPlaying
    }
    
    fileprivate func setupPlayerView() {
        let link = "https://zmp3-mp3-mv1-te-vnno-vn-1.zadn.vn/4efc52c16c8485dadc95/168176087412415806?authen=exp=1511320039~acl=/4efc52c16c8485dadc95/*~hmac=80900fbd5c13bdb1e2de31b5a5ed27e2"
        
        if let url = URL(string: link) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                let minutesString = String(format: "%02d", Int(seconds / 60))
                
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                //lets move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                    
                }
                
            })
        }
    }
    
    func abc() {
//        playerView = AVPlayerViewController()
//        //        let path = Bundle.main.path(forResource: "720p", ofType: ".mp4")
//        //        let url = URL(fileURLWithPath: path!)
//        let url:URL = URL(string: "https://zmp3-mp3-mv1-te-vnno-vn-1.zadn.vn/4efc52c16c8485dadc95/168176087412415806?authen=exp=1511320039~acl=/4efc52c16c8485dadc95/*~hmac=80900fbd5c13bdb1e2de31b5a5ed27e2")!
//        playerView.player = AVPlayer(url: url)
//        let height = view.frame.width * 9 / 16
//        playerView.view.frame = CGRect(x: 0, y: 30, width: view.frame.width, height: height)
//        view.addSubview(playerView.view)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
            
            if lockShowPauseButton == true {
                isPlaying = true
                pausePlayButton.isHidden = false
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (time) in
                    self.pausePlayButton.isHidden = true
                    self.lockShowPauseButton = false
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}


