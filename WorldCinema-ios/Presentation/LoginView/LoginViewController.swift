//
//  LoginViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 27.03.2023.
//

import UIKit

class LoginViewController: UIViewController {
    private var displayingMode = LoginViewDisplayingMode.authorization
    var viewModel = MainComponent().loginComponent.loginViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let authoriationViewController = MainComponent().authorizationComponent.authorizationViewController
//        addChild(authoriationViewController)
//        view.addSubview(authoriationViewController.view)
//        authoriationViewController.didMove(toParent: self)
        
        
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(displayingMode)
    }
    
    private func configure() {
        let cinemaImageView: UIImageView = {
            let cinemaView = UIImageView()
            cinemaView.image = UIImage(named: "LauchScreenLogo")
            return cinemaView
        }()
        
        let signInButton: UIButton = {
            let signInButton = UIButton()
            signInButton.setTitleColor(.white, for: .normal)
            signInButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 14)
            signInButton.layer.cornerRadius = 4
            signInButton.backgroundColor = .red
            return signInButton
        }()
        
        let registrationButton: UIButton = {
            let registrationButton = UIButton()
            registrationButton.setTitleColor(.red, for: .normal)
            registrationButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 14)
            registrationButton.layer.borderColor = UIColor.lightGray.cgColor
            registrationButton.layer.borderWidth = 1
            registrationButton.layer.cornerRadius = 4
            registrationButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return registrationButton
        }()
        
        let buttonsStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 20
            return stackView
        }()
        
        switch displayingMode {
        case .authorization:
            signInButton.setTitle("Войти", for: .normal)
            registrationButton.setTitle("Регистрация", for: .normal)
        case .registration:
            signInButton.setTitle("Зарегистироваться", for: .normal)
            registrationButton.setTitle("У меня уже есть аккаунт", for: .normal)
        }
        
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(registrationButton)
        
        view.addSubview(buttonsStackView)
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(78)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.11).inset(-15)
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        viewModel.updateDisplayMode()
        print(viewModel.updatedViewMode)
    }
}
