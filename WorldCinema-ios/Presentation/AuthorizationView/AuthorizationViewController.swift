//
//  AuthorizationViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 24.03.2023.
//

import Combine
import SnapKit
import SPAlert
import UIKit

class AuthorizationViewController: UIViewController {
    var viewModel: AuthorizationViewModel
    private let rootViewController = MainComponent().registrationComponent.registrationViewController
    var subscribers: Set<AnyCancellable> = []
    
    let emailTextField = CustomTextField(placeholder: "E-mail")
    let passwordTextField = CustomTextField(placeholder: "Пароль")
    
    let signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.setTitle("Войти", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
        signInButton.layer.cornerRadius = 4
        return signInButton
    }()
    
    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.cleanFields()
        
        viewModel.$emailFieldText.sink { [self] text in
            emailTextField.text = text
        }.store(in: &subscribers)
        
        viewModel.$passwordFieldText.sink { [self] text in
            passwordTextField.text = text
        }.store(in: &subscribers)
    }
    
    // MARK: Configure button bindings
    
    private func bind() {
        emailTextField.textPublisher
            .assign(to: \.emailFieldText, on: viewModel)
            .store(in: &subscribers)
        
        passwordTextField.textPublisher
            .assign(to: \.passwordFieldText, on: viewModel)
            .store(in: &subscribers)
        
        viewModel.$areTextFieldsValid.sink { [self] value in
            
            value ? signInButton.buttonActive() : signInButton.buttonEnable()
        }.store(in: &subscribers)
    }

    // MARK: Add UI
    
    private func configure() {
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
        
        let scrollFieldView = UIScrollView()
        let fieldView = UIView()
        
        let registrationButton: UIButton = {
            let registrationButton = UIButton()
            registrationButton.setTitle("Регистрация", for: .normal)
            registrationButton.setTitleColor(.red, for: .normal)
            registrationButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
            registrationButton.layer.borderColor = UIColor.lightGray.cgColor
            registrationButton.layer.borderWidth = 1
            registrationButton.layer.cornerRadius = 4
            return registrationButton
        }()
        
        view.backgroundColor = .black
        
        passwordTextField.isSecureTextEntry = true
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(registrationButton)
        
        view.addSubview(scrollFieldView)
        
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        
        scrollFieldView.addSubview(fieldView)
        fieldView.addSubview(textFieldStackView)
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(registrationButton)
        view.addSubview(cinemaImageView)
        
        cinemaImageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            
            make.width.equalTo(super.view.snp.width).multipliedBy(0.6)
        }
        
        scrollFieldView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.leading.equalTo(super.view.snp.leading)
            make.bottom.top.equalTo(super.view.snp.bottom)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.55)
        }

        fieldView.snp.makeConstraints { make in
            make.trailing.equalTo(scrollFieldView.snp.trailing)
            make.leading.equalTo(scrollFieldView.snp.leading)
            make.width.equalTo(super.view.snp.width)
            make.top.equalTo(scrollFieldView.snp.top)
            make.bottom.equalTo(scrollFieldView.snp.bottom)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.5).inset(-25)
        }

        textFieldStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(fieldView).inset(16)
            make.top.equalTo(fieldView.snp.top)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.11).inset(-15)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(78)
            make.height.equalTo(super.view.snp.height).multipliedBy(0.11).inset(-15)
        }
       
        UITextField.appearance().tintColor = .lightGray
        
        registrationButton.addTarget(self, action: #selector(tapOnRegistrationButton(sender:)), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(tapOnSignInButton(sender:)), for: .touchUpInside)
    }
    
    // MARK: Add actions on button
    
    @objc func tapOnRegistrationButton(sender: UIButton) {
        sender.startAnimatingPressActions()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true)
    }
    
    @objc func tapOnSignInButton(sender: UIButton) {
        sender.startAnimatingPressActions()
        viewModel.login()
    }
}
