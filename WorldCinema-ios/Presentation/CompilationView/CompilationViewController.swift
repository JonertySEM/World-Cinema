//
//  CompilationViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import Combine
import UIKit

class CompilationViewController: UIViewController {
    var viewModel: CompilationViewModel
    
    private var divisor: CGFloat!
    
    private var cardsList = [MovieResponse]()
    private var subscribers: Set<AnyCancellable> = []
    private var cardsArrayList = [UIImageView]()
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoaderView.startLoading()
        divisor = (view.frame.width / 2) / 0.61
        
        viewModel.getCardsMovie()
        
        viewModel.$isShowingCards.sink { [self] flag in
            if flag {
                LoaderView.endLoading()
                createUI()
                addSwipe()
            }
        }.store(in: &subscribers)
        
        viewModel.$compilationCardsMovie.sink { [self] movies in
            cardsList = movies
        }.store(in: &subscribers)
    }
    
    override func viewWillLayoutSubviews() {
        likeButton.layer.cornerRadius = likeButton.frame.height / 2
        disLikeButton.layer.cornerRadius = disLikeButton.frame.height / 2
        playButton.layer.cornerRadius = playButton.frame.height / 2
    }
    
    init(viewModel: CompilationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var tvImage: UIImageView = {
        let image = UIImageView()
        image.image = R.image.sadTV()
        image.isHidden = true
        image.layer.cornerRadius = 16
        image.contentMode = .scaleToFill
        return image
    }()
    
    private var likeImage: UIImageView = {
        let image = UIImageView()
        image.image = R.image.likeInCard()
        image.isHidden = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    private var dislikeImage: UIImageView = {
        let image = UIImageView()
        image.image = R.image.dislikeInCard()
        image.isHidden = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    private var textBottomTv: UILabel = {
        let label = UILabel()
        label.text = "Новые фильмы в подборке закончились"
        label.textAlignment = .center
        label.isHidden = true
        label.font = R.font.sfProTextRegular(size: 30)
        label.numberOfLines = 2
        label.textColor = GetHexColorHelper().hexStringToUIColor(hex: "#AFAFAF")
        return label
    }()
    
    private var likeButton: CustomButton = {
        let button = CustomButton()
        button.setImage(R.image.likeButton(), for: .normal)
        button.backgroundColor = .white
        button.contentMode = .scaleToFill
        
        button.layer.masksToBounds = true
        return button
    }()
    
    private var disLikeButton: CustomButton = {
        let button = CustomButton()
        button.setImage(R.image.dislikeCompilation(), for: .normal)
        button.backgroundColor = .white
        button.contentMode = .scaleToFill
        button.layer.cornerRadius = button.frame.width / 2
        return button
    }()
    
    private var playButton: CustomButton = {
        let button = CustomButton()
        button.setImage(R.image.playCompilation(), for: .normal)
        button.backgroundColor = GetHexColorHelper().hexStringToUIColor(hex: "#EF3A01")
        button.contentMode = .scaleToFill
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.width / 2
        return button
    }()
    
    private var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.contentMode = .scaleToFill
        stack.spacing = 44
        stack.distribution = .fillEqually
        return stack
    }()
    
    private var imageViewCard: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        image.contentMode = .scaleToFill
        return image
    }()
    
    private var secondViewCard: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.alpha = 0
        image.contentMode = .scaleToFill
        return image
    }()
    
    private var textFilmLabel: UILabel = {
        let label = UILabel()
        label.text = "Altered Carbon"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = R.font.sfProTextBold(size: 24)
        label.textColor = .white
        return label
    }()
    
    private func addSwipe() {
        let tap = UIPanGestureRecognizer(target: self, action: #selector(handleTapRed(_:)))
        let tapGreen = UIPanGestureRecognizer(target: self, action: #selector(handleTapGreen(_:)))
        imageViewCard.isUserInteractionEnabled = true
        imageViewCard.addGestureRecognizer(tapGreen)
        
        secondViewCard.isUserInteractionEnabled = true
        secondViewCard.addGestureRecognizer(tap)
        
        likeButton.addTarget(self, action: #selector(likeTap), for: .touchUpInside)
        disLikeButton.addTarget(self, action: #selector(dislikeTap), for: .touchUpInside)
    }
    
    private func checkNewData(view: UIImageView) {
        if currentIndex <= cardsList.count-1 {
            guard let url = URL(string: cardsList[currentIndex].poster) else { return }
            LoadFileHelper.loadImge(withUrl: url, view: view)
            textFilmLabel.text = cardsList[currentIndex].name
            currentIndex += 1
        } else {
            imageViewCard.alpha = 0
            secondViewCard.alpha = 0
            textFilmLabel.alpha = 0
            buttonStackView.alpha = 0
            
            tvImage.isHidden = false
            textBottomTv.isHidden = false
        }
       
        
       
    }
    
    @objc func dislikeTap() {
        let centerX = imageViewCard.center.x - imageViewCard.center.x
        
        likeImage.alpha = abs(centerX) / view.center.x
        dislikeImage.alpha = abs(centerX) / view.center.x
        
        if imageViewCard.alpha == 1 {
            UIView.animate(withDuration: 0.3) { [self] in
                imageViewCard.center = CGPoint(x: imageViewCard.center.x - 400, y: imageViewCard.center.y + 75)
                imageViewCard.alpha = 0
            }
            
            if imageViewCard.alpha == 0 {
                UIView.animate(withDuration: 0.2) {
                    self.secondViewCard.transform = .identity
                    self.secondViewCard.center = self.view.center
                    self.likeImage.alpha = 0
                    self.dislikeImage.alpha = 0
                    self.secondViewCard.alpha = 1
                }
                checkNewData(view: secondViewCard)
            }
            
        } else {
            UIView.animate(withDuration: 0.3) { [self] in
                secondViewCard.center = CGPoint(x: secondViewCard.center.x - 400, y: secondViewCard.center.y + 75)
                secondViewCard.alpha = 0
            }
            
            if secondViewCard.alpha == 0 {
                UIView.animate(withDuration: 0.2) {
                    self.imageViewCard.transform = .identity
                    self.imageViewCard.center = self.view.center
                    self.likeImage.alpha = 0
                    self.dislikeImage.alpha = 0
                    self.imageViewCard.alpha = 1
                }
                checkNewData(view: imageViewCard)
            }
        }
    }
    
    @objc func likeTap() {
        let centerX = imageViewCard.center.x - imageViewCard.center.x
        
        likeImage.alpha = abs(centerX) / view.center.x
        dislikeImage.alpha = abs(centerX) / view.center.x
        
        if imageViewCard.alpha == 1 {
            UIView.animate(withDuration: 0.3) { [self] in
                imageViewCard.center = CGPoint(x: imageViewCard.center.x + 400, y: imageViewCard.center.y + 75)
                imageViewCard.alpha = 0
            }
            
            if imageViewCard.alpha == 0 {
                UIView.animate(withDuration: 0.2) {
                    self.secondViewCard.transform = .identity
                    self.secondViewCard.center = self.view.center
                    self.likeImage.alpha = 0
                    self.dislikeImage.alpha = 0
                    self.secondViewCard.alpha = 1
                }
                checkNewData(view: secondViewCard)
            }
            
        } else {
            UIView.animate(withDuration: 0.3) { [self] in
                secondViewCard.center = CGPoint(x: secondViewCard.center.x + 400, y: secondViewCard.center.y + 75)
                secondViewCard.alpha = 0
            }
            
            if secondViewCard.alpha == 0 {
                UIView.animate(withDuration: 0.2) {
                    self.imageViewCard.transform = .identity
                    self.imageViewCard.center = self.view.center
                    self.likeImage.alpha = 0
                    self.dislikeImage.alpha = 0
                    self.imageViewCard.alpha = 1
                }
                checkNewData(view: imageViewCard)
            }
        }
    }
    
    @objc func handleTapRed(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let centerX = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        card.transform = .identity
    
        card.transform = CGAffineTransform(rotationAngle: centerX / divisor)
        
        if centerX > 0 {
            dislikeImage.isHidden = true
            likeImage.isHidden = false
            
        } else {
            likeImage.isHidden = true
            dislikeImage.isHidden = false
        }
        
        likeImage.alpha = abs(centerX) / view.center.x
        dislikeImage.alpha = abs(centerX) / view.center.x
        
        card.alpha = 1
        
        if sender.state == UIGestureRecognizer.State.ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                }
                if secondViewCard.alpha == 0 {
                    UIView.animate(withDuration: 0.2) {
                        self.imageViewCard.transform = .identity
                        self.imageViewCard.center = self.view.center
                        self.likeImage.alpha = 0
                        self.dislikeImage.alpha = 0
                        self.imageViewCard.alpha = 1
                    }
                    checkNewData(view: imageViewCard)
                }
                return
            } else if card.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                }
                if secondViewCard.alpha == 0 {
                    UIView.animate(withDuration: 0.2) {
                        self.imageViewCard.transform = .identity
                        self.imageViewCard.center = self.view.center
                        self.likeImage.alpha = 0
                        self.dislikeImage.alpha = 0
                        self.imageViewCard.alpha = 1
                    }
                    checkNewData(view: imageViewCard)
                }
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = self.view.center
                self.likeImage.alpha = 0
                self.dislikeImage.alpha = 0
            }
        }
    }
    
    @objc func handleTapGreen(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let centerX = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        card.transform = .identity
    
        card.transform = CGAffineTransform(rotationAngle: centerX / divisor)
        
        if centerX > 0 {
            dislikeImage.isHidden = true
            likeImage.isHidden = false
            
        } else {
            likeImage.isHidden = true
            dislikeImage.isHidden = false
        }
        
        likeImage.alpha = abs(centerX) / view.center.x
        dislikeImage.alpha = abs(centerX) / view.center.x
        
        card.alpha = 1
        
        if sender.state == UIGestureRecognizer.State.ended {
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                }
                if imageViewCard.alpha == 0 {
                    UIView.animate(withDuration: 0.2) {
                        self.secondViewCard.transform = .identity
                        self.secondViewCard.center = self.view.center
                        self.likeImage.alpha = 0
                        self.dislikeImage.alpha = 0
                        self.secondViewCard.alpha = 1
                    }
                    checkNewData(view: secondViewCard)
                }
                return
            } else if card.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                }
                if imageViewCard.alpha == 0 {
                    UIView.animate(withDuration: 0.2) {
                        self.secondViewCard.transform = .identity
                        self.secondViewCard.center = self.view.center
                        self.likeImage.alpha = 0
                        self.dislikeImage.alpha = 0
                        self.secondViewCard.alpha = 1
                    }
                    checkNewData(view: secondViewCard)
                }
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = self.view.center
                self.likeImage.alpha = 0
                self.dislikeImage.alpha = 0
            }
        }
    }
    
    private func createUI() {
        if currentIndex != cardsList.count - 1 {
            guard let url = URL(string: cardsList[currentIndex].poster) else { return }
            LoadFileHelper.loadImge(withUrl: url, view: imageViewCard)

            textFilmLabel.text = cardsList[currentIndex].name
            
            currentIndex += 1
        }
        view.addSubview(tvImage)
        view.addSubview(textBottomTv)
        
        view.addSubview(textFilmLabel)
        
        view.addSubview(buttonStackView)
        view.addSubview(secondViewCard)
        view.addSubview(imageViewCard)
    
        buttonStackView.addArrangedSubview(disLikeButton)
        buttonStackView.addArrangedSubview(playButton)
        buttonStackView.addArrangedSubview(likeButton)
        
        imageViewCard.addSubview(likeImage)
        imageViewCard.addSubview(dislikeImage)
        
        likeImage.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(imageViewCard)
        }
        dislikeImage.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(imageViewCard)
        }
        
        textFilmLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(super.view.snp.top).inset(68)
        }
        
        imageViewCard.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.68)
            make.top.equalTo(textFilmLabel.snp.bottom).inset(-24)
        }
        
        secondViewCard.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.68)
            make.top.equalTo(textFilmLabel.snp.bottom).inset(-24)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(60)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.08)
            make.top.equalTo(imageViewCard.snp.bottom).inset(-32)
            make.bottom.equalTo(super.view.snp.bottom).inset(40)
        }
        
        likeButton.snp.makeConstraints { make in
            make.height.equalTo(likeButton.snp.width).multipliedBy(1.0)
        }
        
        disLikeButton.snp.makeConstraints { make in
            make.height.equalTo(disLikeButton.snp.width).multipliedBy(1.0)
        }
        
        playButton.snp.makeConstraints { make in
            make.height.equalTo(playButton.snp.width).multipliedBy(1.0)
        }
        
        textBottomTv.snp.makeConstraints { make in
            make.top.equalTo(tvImage.snp.bottom).inset(-32)
            make.leading.trailing.equalToSuperview().inset(44)
        }

        tvImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().inset(80)
        }
        
        if cardsList.isEmpty {
            imageViewCard.alpha = 0
            secondViewCard.alpha = 0
            textFilmLabel.alpha = 0
            buttonStackView.alpha = 0
            textBottomTv.isHidden = false
            tvImage.isHidden = false
        }
    }
}
