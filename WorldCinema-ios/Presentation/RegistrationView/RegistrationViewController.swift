//
//  RegistrationViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 29.03.2023.
//

import Combine
import UIKit

class RegistrationViewController: UIViewController {
    private var viewModel: RegistrationViewModel
    var subscribers: Set<AnyCancellable> = []
    
    let nameTextField = CustomTextField(placeholder: R.string.localizable.firstName())
    let surNameTextField = CustomTextField(placeholder: R.string.localizable.secondName())
    let emailTextField = CustomTextField(placeholder: R.string.localizable.email())
    let passwordTextField = CustomTextField(placeholder: R.string.localizable.password())
    let confrimPasswordTextField = CustomTextField(placeholder: R.string.localizable.confrimPassword())
    
    let signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.setTitle(R.string.localizable.pressRegistrationButton(), for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.titleLabel?.font = R.font.sfProTextBold(size: 15)
        signInButton.layer.cornerRadius = 4
        return signInButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        viewModel.cleanFields()
        
        viewModel.$firstNameFieldText.sink { [self] text in
            nameTextField.text = text
        }.store(in: &subscribers)
        
        viewModel.$secondNameFieldText.sink { [self] text in
            surNameTextField.text = text
        }.store(in: &subscribers)
        
        viewModel.$emailFieldText.sink { [self] text in
            emailTextField.text = text
        }.store(in: &subscribers)
        
        viewModel.$passwordFieldText.sink { [self] text in
            passwordTextField.text = text
        }.store(in: &subscribers)
        
        viewModel.$confirmPasswordText.sink { [self] text in
            confrimPasswordTextField.text = text
        }.store(in: &subscribers)
    }
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        nameTextField.textPublisher
            .assign(to: \.firstNameFieldText, on: viewModel)
            .store(in: &subscribers)
        
        surNameTextField.textPublisher
            .assign(to: \.secondNameFieldText, on: viewModel)
            .store(in: &subscribers)
        
        emailTextField.textPublisher
            .assign(to: \.emailFieldText, on: viewModel)
            .store(in: &subscribers)
        
        passwordTextField.textPublisher
            .assign(to: \.passwordFieldText, on: viewModel)
            .store(in: &subscribers)
        
        confrimPasswordTextField.textPublisher
            .assign(to: \.confirmPasswordText, on: viewModel)
            .store(in: &subscribers)
        
        viewModel.$areTextFieldsValid.sink { [self] value in
            
            value ? signInButton.buttonActive() : signInButton.buttonEnable()
        }.store(in: &subscribers)
    }
    
    private func configure() {
        let scrollFieldView = UIScrollView()
        let fieldView = UIView()
        
        let cinemaImageView: UIImageView = {
            let cinemaView = UIImageView()
            cinemaView.image = R.image.lauchScreenLogo()
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
        
        let registrationButton: UIButton = {
            let registrationButton = UIButton()
            registrationButton.setTitle(R.string.localizable.haveAccount(), for: .normal)
            registrationButton.setTitleColor(.red, for: .normal)
            registrationButton.titleLabel?.font = R.font.sfProTextBold(size: 15)
            registrationButton.layer.borderColor = UIColor.lightGray.cgColor
            registrationButton.layer.borderWidth = 1
            registrationButton.layer.cornerRadius = 4
            return registrationButton
        }()
        
        view.backgroundColor = .black
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        buttonsStackView.addArrangedSubview(signInButton)
        buttonsStackView.addArrangedSubview(registrationButton)
        
        view.addSubview(scrollFieldView)
        
        passwordTextField.isSecureTextEntry = true
        confrimPasswordTextField.isSecureTextEntry = true
        
        textFieldStackView.addArrangedSubview(nameTextField)
        textFieldStackView.addArrangedSubview(surNameTextField)
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
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
        
        registrationButton.addTarget(self, action: #selector(tapOnRegistrationButton(sender:)), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(tapOnSignIn(sender:)), for: .touchUpInside)
    }
    
    @objc func tapOnSignIn(sender: UIButton) {
        sender.startAnimatingPressActions()
        viewModel.registration()
    }
    
    @objc func tapOnRegistrationButton(sender: UIButton) {
        sender.startAnimatingPressActions()
        dismiss(animated: true, completion: nil)
    }
}
