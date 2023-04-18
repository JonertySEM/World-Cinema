//
//  TagCollectionView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Foundation
import UIKit

class TagCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    lazy var tagCollectionView: UICollectionView = { [unowned self] in
        let layout = TagFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tagCollectionView.backgroundColor = .black
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.collectionViewLayout = layout
        tagCollectionView.register(CustomTegCell.self, forCellWithReuseIdentifier: "cell")

        return tagCollectionView
    }()

    private let tagList: [TagResponse]

    init(
        tagList: [TagResponse]

    ) {
        self.tagList = tagList
        super.init(frame: .zero)

        addSubview(tagCollectionView)

        tagCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tagCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tagCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tagCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

    internal func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = R.font.sfProTextBold(size: 14)
        label.text = tagList[indexPath.row].tagName
        label.textColor = .white
        label.sizeToFit()
        let size = label.frame.size
        return CGSize(width: size.width + 30, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomTegCell

        let tagMovie = tagList[indexPath.row]

        cell.tagLabel.text = tagMovie.tagName
        cell.layer.borderColor = GetHexColorHelper().hexStringToUIColor(hex: "#EF3A01").cgColor
        cell.layer.borderWidth = 1
        cell.tagLabel.textColor = .white
        cell.tagLabel.textAlignment = .center
        cell.layer.cornerRadius = 4
        cell.backgroundColor = GetHexColorHelper().hexStringToUIColor(hex: "#EF3A01")


        return cell
    }
}
