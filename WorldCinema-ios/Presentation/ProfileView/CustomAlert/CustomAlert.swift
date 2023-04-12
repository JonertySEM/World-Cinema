//
//  CustomAlert.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 10.04.2023.
//

import Foundation
import SnapKit
import UIKit

class CustomAlert {
    private var backgroudView: UIView = {
        let background = UIView()
        background.backgroundColor = .black
        background.alpha = 0
        return background
    }()
    
    private var myCurrentView: UIView?
    
    private var myAlert: UIView = {
        let myView = UIView()
        myView.backgroundColor = .black
        myView.layer.borderColor = UIColor.lightGray.cgColor
        myView.layer.borderWidth = 1
        myView.layer.masksToBounds = true
        myView.layer.cornerRadius = 4
        return myView
        
    }()
    
    private let stackInAlert: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.contentMode = .scaleToFill
        stack.spacing = 25
        return stack
    }()
    
    let addAvatarInGalery: UILabel = {
        let label = UILabel()
        label.text = "Добавить фото с галереи"
        label.textAlignment = .center
        label.font = R.font.sfProTextBold(size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .red
        return label
    }()

    let addAvatarInCamera: UILabel = {
        let label = UILabel()
        label.text = "Добавить фото с камеры"
        label.textAlignment = .center
        label.font = R.font.sfProTextBold(size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .red
        return label
        
    }()
    
    func showAlert(on viewController: UIViewController) {
        guard let currentView = viewController.view else { return }
        
        myCurrentView = currentView
        
        backgroudView.frame = currentView.bounds
        currentView.addSubview(backgroudView)
        
        currentView.addSubview(myAlert)
        myAlert.frame = CGRect(x: currentView.frame.size.width / 8,
                               y: currentView.frame.minY - (currentView.frame.size.height / 2),
                               width: currentView.frame.size.width - 80,
                               height: currentView.frame.size.height / 5)
        
        myAlert.addSubview(stackInAlert)
        stackInAlert.addArrangedSubview(addAvatarInGalery)
        stackInAlert.addArrangedSubview(addAvatarInCamera)
       
        stackInAlert.snp.makeConstraints { make in
            make.leading.equalTo(myAlert.snp.leading).inset(16)
            make.trailing.equalTo(myAlert.snp.trailing).inset(16)
            make.height.equalTo(myAlert.snp.height).multipliedBy(0.5)
            make.centerX.centerY.equalTo(myAlert)
        }
        addAvatarInCamera.snp.makeConstraints { make in
            make.height.equalTo(addAvatarInGalery.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeAlert(sender:)))
        
        backgroudView.addGestureRecognizer(tapGesture)
        
        UIView.animate(withDuration: 0.25) {
            self.backgroudView.alpha = 0.6
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.5) {
                    self.myAlert.center = currentView.center
                }
            }
        }
    }
    
    @objc func closeAlert(sender: UITapGestureRecognizer) {
        guard let currentView = myCurrentView else { return }
        
        UIView.animate(withDuration: 0.5) {
            self.myAlert.frame = CGRect(x: currentView.frame.size.width / 8,
                                        y: currentView.frame.maxY,
                                        width: currentView.frame.size.width - 80,
                                        height: currentView.frame.size.height / 5)
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.backgroudView.alpha = 0
                } completion: { done in
                    if done {
                        self.addAvatarInGalery.removeFromSuperview()
                        self.addAvatarInCamera.removeFromSuperview()
                        self.stackInAlert.removeFromSuperview()
                        self.myAlert.removeFromSuperview()
                        self.backgroudView.removeFromSuperview()
                    }
                }
            }
        }
    }
}
