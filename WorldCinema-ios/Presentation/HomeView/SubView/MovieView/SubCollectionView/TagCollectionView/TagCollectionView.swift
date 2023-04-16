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
        let layout = TagCollectionLayout(minimumInteritemSpacing: 8, minimumLineSpacing: 8)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tagCollectionView.backgroundColor = GetHexColorHelper().hexStringToUIColor(hex: "#150D0B")
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.5, height: collectionView.frame.width/2)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomTegCell
        cell.backgroundColor = .red
        return cell
//        let displayingMovie = movieList[indexPath.row]
//        return getCellOfNewMovies(cell: cell, movie: displayingMovie)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // movieTapClosure?(movieList[indexPath.item])
    }

    private func getCellOfNewMovies(cell: UICollectionViewCell, movie: MovieResponse) -> UICollectionViewCell {
        let backgroundImageView = UIImageView()

        if let displayingMovieFirstUrl = movie.imageUrls.first {
            if let imageUrl = URL(string: displayingMovieFirstUrl) {
                LoadFileHelper.loadImge(withUrl: imageUrl, view: backgroundImageView)
            }
        }

        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.masksToBounds = true

        cell.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        return cell
    }
    
    
}

