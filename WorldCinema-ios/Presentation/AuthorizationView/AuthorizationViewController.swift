//
//  AuthorizationViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 24.03.2023.
//

import SnapKit
import UIKit

class AuthorizationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let cinemaImageView: UIImageView = {
            let cinemaView = UIImageView()
            cinemaView.image = UIImage(named: "LauchScreenLogo")
            return cinemaView
        }()
        
        let emailTextField = CustomTextField(placeholder: "E-mail")
        let passwortTextField = CustomTextField(placeholder: "Пароль")
        
        let textFieldStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 20
            return stackView
        }()

        let buttonsStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 20
            return stackView
        }()
        
        let signInButton: UIButton = {
            let signInButton = UIButton()
            signInButton.setTitle("Войти", for: .normal)
            signInButton.setTitleColor(.white, for: .normal)
            signInButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 14)
            signInButton.layer.cornerRadius = 4
            signInButton.backgroundColor = .red
            return signInButton
        }()
        
        let registrationButton: UIButton = {
            let registrationButton = UIButton()
            registrationButton.setTitle("Регистрация", for: .normal)
            registrationButton.setTitleColor(.red, for: .normal)
            registrationButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 14)
            registrationButton.layer.borderColor = UIColor.lightGray.cgColor
            registrationButton.layer.borderWidth = 1
            registrationButton.layer.cornerRadius = 4
            return registrationButton
        }()
        
        view.backgroundColor = .black
        
        view.addSubview(cinemaImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwortTextField)
        
        view.addSubview(textFieldStackView)
        view.addSubview(buttonsStackView)
        
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwortTextField)
        
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(registrationButton)

        cinemaImageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview().inset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(82)
            make.width.equalTo(cinemaImageView.snp.height).multipliedBy(2 / 3)
        }

        textFieldStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(buttonsStackView.snp.top).inset(-156)
            make.top.equalTo(cinemaImageView.snp.bottomMargin).inset(-65)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.11).inset(-15)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(156)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(78)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.11).inset(-15)
        }
        
        UITextField.appearance().tintColor = .lightGray
    }
}
