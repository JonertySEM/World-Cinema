//
//  ProfileViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 03.04.2023.
//

import Combine
import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    var viewModel: ProfileViewModel
    private let avatarAllert = CustomAlert()
    var subscribers: Set<AnyCancellable> = []
    
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
        
        LoaderView.startLoading()
        viewModel.getProfileData()
        
        viewModel.$isProgressProfileShowing.sink { [self] result in
            if result {
                LoaderView.endLoading()
                createProfile()
            }
        }.store(in: &subscribers)
        
        viewModel.$avatar.sink { [self] url in
            guard let imageUrl = URL(string: url) else { return }
            LoadFileHelper.loadImgeAvatar(withUrl: imageUrl, view: userAvatar)
        }.store(in: &subscribers)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.$userName.sink { [self] name in
            userName.text = name
        }.store(in: &subscribers)
        
        viewModel.$userEmail.sink { [self] email in
            userEmail.text = email
        }.store(in: &subscribers)
    }
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Тандзиро Камадо"
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
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        sender.view?.showAnimation {
            self.avatarAllert.showAlert(on: self)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.uploadImageInGallery))
            self.avatarAllert.addAvatarInGalery.isUserInteractionEnabled = true
            self.avatarAllert.addAvatarInGalery.addGestureRecognizer(tapGesture)
            
            let tapGestureCamera = UITapGestureRecognizer(target: self, action: #selector(self.uploadImageInCamera))
            self.avatarAllert.addAvatarInCamera.isUserInteractionEnabled = true
            self.avatarAllert.addAvatarInCamera.addGestureRecognizer(tapGestureCamera)
        }
    }
    
    @objc func uploadImageInGallery(_ sender: UITapGestureRecognizer) {
        sender.view?.showAnimation {
            let viewController = UIImagePickerController()
            viewController.allowsEditing = true
            viewController.sourceType = .photoLibrary
            viewController.delegate = self
            viewController.allowsEditing = true
            
            self.present(viewController, animated: true)
        }
    }
    
    @objc func uploadImageInCamera(_ sender: UITapGestureRecognizer) {
        sender.view?.showAnimation {
            let viewController = UIImagePickerController()
            viewController.sourceType = .camera
            viewController.delegate = self
            viewController.allowsEditing = true
            
            self.present(viewController, animated: true)
        }
    }
    
    let changeAvatar: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.changeAvatar()
        
        label.font = R.font.sfProTextBold(size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = GetHexColorHelper().hexStringToUIColor(hex: "#EF3A01")
        return label
    }()
    
    let messageText: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.messageText()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = R.font.sfProTextBold(size: 15)
        label.textColor = .white
        return label
    }()
    
    let storyText: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.storyText()
        label.font = R.font.sfProTextBold(size: 15)
        label.textColor = .white
        return label
    }()
    
    let settingText: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.settingsText()
        label.font = R.font.sfProTextBold(size: 15)
        label.textColor = .white
        return label
    }()
    
    let buttonExit: CustomButton = {
        let button = CustomButton()
        button.setTitle(R.string.localizable.exitButton(), for: .normal)
        button.setTitleColor(GetHexColorHelper().hexStringToUIColor(hex: "#EF3A01"), for: .normal)
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
            make.height.equalTo(super.view.snp.height).multipliedBy(0.12)
            make.height.equalTo(userAvatar.snp.width).multipliedBy(1.0 / 1.0)
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        changeAvatar.isUserInteractionEnabled = true
        changeAvatar.addGestureRecognizer(tapGesture)
        
        buttonExit.addTarget(self, action: #selector(pressExitButton), for: .touchUpInside)
    }
    
    @objc func pressExitButton() {
        viewModel.pressExit()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            userAvatar.image = image
            userAvatar.layer.cornerRadius = userAvatar.frame.size.width / 2
            
            userAvatar.clipsToBounds = true
            
            viewModel.uploadAvatar(data: userAvatar.image!.jpegData(compressionQuality: 1.0))
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
