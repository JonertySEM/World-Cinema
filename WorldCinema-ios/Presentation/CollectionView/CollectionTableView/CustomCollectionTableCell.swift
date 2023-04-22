//
//  CustomCollectionTableCell.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import SnapKit
import UIKit

class CustomCollectionTableCell: UITableViewCell {
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.sfProTextBold(size: 14)
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = R.font.sfProTextBold(size: 14)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
