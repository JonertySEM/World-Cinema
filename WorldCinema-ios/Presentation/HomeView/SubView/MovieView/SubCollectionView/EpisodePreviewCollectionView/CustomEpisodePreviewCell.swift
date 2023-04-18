//
//  CustomEpisodePreviewCell.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Foundation
import UIKit

class CustomEpisodePreviewCell: UICollectionViewCell {
    let titleEpisode: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.init(Float(250)), for: .vertical)
        label.setContentCompressionResistancePriority(.init(Float(1000)), for: .vertical)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = R.font.sfProTextBold(size: 16)
        label.textColor = .white
        return label
    }()
    
    let descripitonEpisode: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProTextRegular(size: 12)
        label.setContentHuggingPriority(.init(Float(250)), for: .vertical)
        label.setContentCompressionResistancePriority(.init(Float(1000)), for: .vertical)
        label.numberOfLines = 2
        label.textColor = GetHexColorHelper().hexStringToUIColor(hex: "#AFAFAF")
        return label
    }()
    
    let yearEpisode: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProTextRegular(size: 12)
        label.setContentHuggingPriority(.init(Float(250)), for: .vertical)
        label.setContentCompressionResistancePriority(.init(Float(750)), for: .vertical)
        label.textColor = GetHexColorHelper().hexStringToUIColor(hex: "#AFAFAF")
        return label
    }()
    
    let previewEpisode: UIImageView = {
        let preview = UIImageView()
        preview.contentMode = .scaleAspectFill
        preview.layer.masksToBounds = true
        return preview
    }()
    
    let textStackWithoutYear: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.contentMode = .scaleToFill
        stack.setContentHuggingPriority(.init(Float(250)), for: .vertical)
        stack.setContentCompressionResistancePriority(.init(Float(750)), for: .vertical)
        stack.spacing = 6
        stack.distribution = .fill
        return stack
    }()
    
    let textWithYear: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.contentMode = .scaleToFill
        stack.spacing = 4
        stack.distribution = .fillProportionally
        return stack
    }()
    
    let stackWithPicture: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 16
        stack.distribution = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(stackWithPicture)
        
        stackWithPicture.addArrangedSubview(previewEpisode)
        stackWithPicture.addArrangedSubview(textWithYear)
        
        textStackWithoutYear.addArrangedSubview(titleEpisode)
        textStackWithoutYear.addArrangedSubview(descripitonEpisode)
        
        textWithYear.addArrangedSubview(textStackWithoutYear)
        textWithYear.addArrangedSubview(yearEpisode)
        
        
        previewEpisode.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.35)
            make.height.equalTo(textWithYear.snp.height).multipliedBy(1.0/1.0)
        }
        
        
        
        stackWithPicture.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview()
        }
        
        
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
