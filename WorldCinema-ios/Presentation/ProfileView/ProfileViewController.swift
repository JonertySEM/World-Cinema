//
//  ProfileViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProfileData()
        createProfile()
    }
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Тандзиро Комадо"
        label.font = R.font.sfProTextBold(size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    let userEmail: UILabel = {
        let label = UILabel()
        label.text = "tandziro34@gmail.com"
        label.font = R.font.sfProTextBold(size: 15)
        label.textColor = .gray
        return label
    }()
    
    let userAvatar: UIImageView = {
        let userAvatar = UIImageView()
        userAvatar.image = UIImage(systemName: "person.circle.fill")
        userAvatar.tintColor = .lightGray
        return userAvatar
    }()
    
    let changeAvatar: UILabel = {
        let label = UILabel()
        label.text = "Изменить"
        label.font = R.font.sfProTextBold(size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .red
        return label
    }()
    
    let messageText: UILabel = {
        let label = UILabel()
        label.text = "Обсуждение"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = R.font.sfProTextBold(size: 15)
        label.textColor = .white
        return label
    }()
    
    let storyText: UILabel = {
        let label = UILabel()
        label.text = "История"
        label.font = R.font.sfProTextBold(size: 15)
        label.textColor = .white
        return label
    }()
    
    let settingText: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = R.font.sfProTextBold(size: 15)
        label.textColor = .white
        return label
    }()
    
    let buttonExit: CustomButton = {
        let button = CustomButton()
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = R.font.sfProTextBold(size: 15)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        return button
    }()
    
    private func createProfile() {
        let userInfo: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.contentMode = .scaleToFill
            stack.spacing = 16
            stack.distribution = .fill
             
            return stack
        }()
        
        let userData: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.contentMode = .scaleToFill
            stack.distribution = .equalSpacing
            stack.spacing = 2
            
            return stack
        }()
        
        let buttonStack: UIStackView = {
            let stack = UIStackView()
            stack.alignment = .center
            stack.axis = .vertical
            stack.spacing = 23
            stack.distribution = .fill
            stack.contentMode = .scaleToFill
            return stack
        }()
        
        let messageStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .top
            stack.distribution = .fill
            stack.spacing = 18
            stack.contentMode = .scaleToFill
            return stack
        }()
        
        let messageStackWithArrow: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 200
            stack.contentMode = .scaleToFill
            return stack
        }()
        
        let messageImage: UIImageView = {
            let image = UIImageView()
            image.image = R.image.messageMovieProfile()
            return image
        }()
        
        let messageArrowRight: UIImageView = {
            let image = UIImageView()
            let configuration = UIImage.SymbolConfiguration(weight: .heavy)
            image.image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
            image.tintColor = .lightGray
            return image
        }()
        
        let storyStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .top
            stack.distribution = .fill
            stack.spacing = 18
            stack.contentMode = .scaleToFill
            return stack
        }()
        
        let storyStackWithArrow: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 200
            stack.contentMode = .scaleToFill
            return stack
        }()
        
        let storyImage: UIImageView = {
            let image = UIImageView()
            image.image = R.image.timeMovieProfile()
            return image
        }()
        
        let storyArrowRight: UIImageView = {
            let image = UIImageView()
            let configuration = UIImage.SymbolConfiguration(weight: .heavy)
            image.image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
            image.tintColor = .lightGray
            
            return image
        }()
        
        let settingStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .top
            stack.distribution = .fill
            stack.spacing = 18
            stack.contentMode = .scaleToFill
            return stack
        }()
        
        let settingStackWithArrow: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 200
            stack.contentMode = .scaleToFill
            return stack
        }()
        
        let settingImage: UIImageView = {
            let image = UIImageView()
            image.image = R.image.settingMovieProfile()
            return image
        }()
        
        let settingArrowRight: UIImageView = {
            let image = UIImageView()
            let configuration = UIImage.SymbolConfiguration(weight: .heavy)
            image.image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
            image.tintColor = .lightGray
            
            return image
        }()
        
        
        
        view.addSubview(userInfo)
        userInfo.addArrangedSubview(userAvatar)
        userInfo.addArrangedSubview(userData)
        userData.addArrangedSubview(userName)
        userData.addArrangedSubview(userEmail)
        view.addSubview(changeAvatar)
        
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(messageStackWithArrow)
        buttonStack.addArrangedSubview(storyStackWithArrow)
        buttonStack.addArrangedSubview(settingStackWithArrow)
        
        messageStackWithArrow.addArrangedSubview(messageStack)
        messageStackWithArrow.addArrangedSubview(messageArrowRight)
        messageStack.addArrangedSubview(messageImage)
        messageStack.addArrangedSubview(messageText)
        
        storyStackWithArrow.addArrangedSubview(storyStack)
        storyStackWithArrow.addArrangedSubview(storyArrowRight)
        storyStack.addArrangedSubview(storyImage)
        storyStack.addArrangedSubview(storyText)
        
        settingStackWithArrow.addArrangedSubview(settingStack)
        settingStackWithArrow.addArrangedSubview(settingArrowRight)
        settingStack.addArrangedSubview(settingImage)
        settingStack.addArrangedSubview(settingText)
        
        view.addSubview(buttonExit)
        
        
        userAvatar.snp.makeConstraints { make in
            make.height.equalTo(userAvatar.snp.width).multipliedBy(1.0 / 1.0)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.1)
        }
        
        userInfo.snp.makeConstraints { make in
            make.top.equalTo(super.view.snp.top).inset(60)
            make.leading.equalTo(super.view.snp.leading).inset(16)
            make.trailing.equalTo(super.view.snp.trailing).inset(64)
        }
        
        changeAvatar.snp.makeConstraints { make in
            make.centerX.equalTo(userAvatar)
            make.leading.equalTo(super.view.snp.leading).inset(24)
            make.top.equalTo(userInfo.snp.bottom).inset(-8)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(changeAvatar.snp.bottom).inset(-58)
        }
        
        messageImage.snp.makeConstraints { make in
            make.height.equalTo(messageImage.snp.width).multipliedBy(1.0 / 1.0)
        }

        messageArrowRight.snp.makeConstraints { make in
            make.width.equalTo(super.view.snp.width).multipliedBy(0.05)
        }
        
        messageStackWithArrow.snp.makeConstraints { make in
            make.height.equalTo(super.view.snp.height).multipliedBy(0.04)
        }
        
        storyStackWithArrow.snp.makeConstraints { make in
            make.height.equalTo(messageStackWithArrow.snp.height)
            make.width.equalTo(messageStackWithArrow.snp.width)
        }

        storyImage.snp.makeConstraints { make in
            make.height.equalTo(storyImage.snp.width).multipliedBy(1.0 / 1.0)
        }

        storyArrowRight.snp.makeConstraints { make in
            make.width.equalTo(super.view.snp.width).multipliedBy(0.05)
        }
        
        settingStackWithArrow.snp.makeConstraints { make in
            make.height.equalTo(messageStackWithArrow.snp.height)
            make.width.equalTo(messageStackWithArrow.snp.width)
        }

        settingImage.snp.makeConstraints { make in
            make.height.equalTo(settingImage.snp.width).multipliedBy(1.0 / 1.0)
        }

        settingArrowRight.snp.makeConstraints { make in
            make.width.equalTo(super.view.snp.width).multipliedBy(0.05)
        }
        
        buttonExit.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.06)
            make.top.equalTo(buttonStack.snp.bottom).inset(-54)
        }
    }
}
