//
//  MessageTableViewCell.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 20.04.2023.
//

import Foundation
import UIKit

class MessageTableViewCell: UITableViewCell {
    private var messageData: ChatResponse?
    private var isCompanion: Bool = false
    
    private lazy var messageTextLabel: UILabel = UILabel()
    private lazy var messageTextBackgroundView: UIView = UIView()
    private lazy var dateLabel: UILabel = UILabel()
    private lazy var userImageView: UIImageView = UIImageView()
    
    private var messageTextBackgroundViewLeadingConstraint: NSLayoutConstraint?
    private var messageTextBackgroundViewTralingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        setupViewByType()
    }
    
    private func setupUI(){
        selectionStyle = .none
        
        setupUserImage()
        //setupMessageTextBackground()
        setupDataTextLabel()
        //setupMessageTextLabel()
        
    }
    
    private func setupUserImage() {
        userImageView.backgroundColor = .red
        userImageView.layer.cornerRadius = 12
        
        contentView.addSubview(userImageView)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            userImageView.widthAnchor.constraint(equalToConstant: 24),
            userImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func setupDataTextLabel() {
        
    }
    
    
    private func setupViewByType() {
        if isCompanion {
            messageTextBackgroundView.backgroundColor = .gray
            messageTextLabel.textColor = .red
            
            dateLabel.textColor = .blue
            
            messageTextBackgroundViewLeadingConstraint?.isActive = false
            messageTextBackgroundViewTralingConstraint?.isActive = true
            
            userImageView.alpha = 1
            
            DispatchQueue.main.async {
                //self.messageTextBackgroundView.
            }
        } else {
            messageTextBackgroundView.backgroundColor = .blue
            messageTextLabel.textColor = isCompanion ? .black : .white
            
            dateLabel.textColor = .lightGray
            
            messageTextBackgroundViewLeadingConstraint?.isActive = false
            messageTextBackgroundViewTralingConstraint?.isActive = true
            
            userImageView.alpha = 0
            
            DispatchQueue.main.async {
                //self.messageTextBackgroundView.
            }
        }
    }
}
