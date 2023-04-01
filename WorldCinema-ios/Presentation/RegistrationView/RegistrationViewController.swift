//
//  RegistrationViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 29.03.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    private var viewModel = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func configure() {
        let scrollFieldView = UIScrollView()
        let fieldView = UIView()
        
        let nameTextField = CustomTextField(placeholder: "Имя")
        let surNameTextField = CustomTextField(placeholder: "Фамилия")
        let emailTextField = CustomTextField(placeholder: "E-mail")
        let passwortTextField = CustomTextField(placeholder: "Пароль")
        let confrimPasswordTextField = CustomTextField(placeholder: "Повторите пароль")
        
        let cinemaImageView: UIImageView = {
            let cinemaView = UIImageView()
            cinemaView.image = UIImage(named: "LauchScreenLogo")
            return cinemaView
        }()
        
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
            signInButton.setTitle("Зарегистрироваться", for: .normal)
            signInButton.setTitleColor(.white, for: .normal)
            signInButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
            signInButton.layer.cornerRadius = 4
            signInButton.backgroundColor = .red
            return signInButton
        }()
        
        let registrationButton: UIButton = {
            let registrationButton = UIButton()
            registrationButton.setTitle("У меня уже есть аккаунт", for: .normal)
            registrationButton.setTitleColor(.red, for: .normal)
            registrationButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
            registrationButton.layer.borderColor = UIColor.lightGray.cgColor
            registrationButton.layer.borderWidth = 1
            registrationButton.layer.cornerRadius = 4
            return registrationButton
        }()
        
        view.backgroundColor = .black
        
        view.addSubview(emailTextField)
        view.addSubview(passwortTextField)
        
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(registrationButton)
        
        view.addSubview(scrollFieldView)
        
        textFieldStackView.addArrangedSubview(nameTextField)
        textFieldStackView.addArrangedSubview(surNameTextField)
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwortTextField)
        textFieldStackView.addArrangedSubview(confrimPasswordTextField)
        
        scrollFieldView.addSubview(fieldView)
        fieldView.addSubview(textFieldStackView)
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(registrationButton)
        view.addSubview(cinemaImageView)
        
        scrollFieldView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.leading.equalTo(super.view.snp.leading)
            make.bottom.top.equalTo(super.view.snp.bottom)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.7)
        }

        fieldView.snp.makeConstraints { make in
            make.trailing.equalTo(scrollFieldView.snp.trailing)
            make.leading.equalTo(scrollFieldView.snp.leading)
            make.width.equalTo(super.view.snp.width)
            make.top.equalTo(scrollFieldView.snp.top)
            make.bottom.equalTo(scrollFieldView.snp.bottom)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.68).inset(-20)
        }

        textFieldStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(fieldView).inset(16)
            make.top.equalTo(fieldView.snp.top)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.3).inset(-45)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.11).inset(-15)
        }
        
        cinemaImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        
            make.width.equalTo(self.view.snp.width).multipliedBy(0.4)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.14)
        }
       
        UITextField.appearance().tintColor = .lightGray
        
        registrationButton.addTarget(self, action: #selector(self.tapOnRegistrationButton(sender:)), for: .touchUpInside)
    }

    @objc func tapOnRegistrationButton(sender: UIButton) {
        sender.startAnimatingPressActions()
        dismiss(animated: true, completion: nil)
    }
}
