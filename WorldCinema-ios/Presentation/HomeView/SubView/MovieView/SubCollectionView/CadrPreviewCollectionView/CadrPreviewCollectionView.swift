//
//  CadrPreviewCollectionView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Foundation
import UIKit

class CadrPreviewCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    lazy var filmPreviewCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionFilmsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionFilmsView.backgroundColor = .black
        collectionFilmsView.delegate = self
        collectionFilmsView.dataSource = self
        collectionFilmsView.translatesAutoresizingMaskIntoConstraints = false
        collectionFilmsView.register(CustomMovieNewCellView.self, forCellWithReuseIdentifier: "cell")

        return collectionFilmsView
    }()

    private let filmPreview: [String]

    init(
        filmPreview: [String]

    ) {
        self.filmPreview = filmPreview
        super.init(frame: .zero)

        addSubview(filmPreviewCollectionView)

        filmPreviewCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        filmPreviewCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        filmPreviewCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        filmPreviewCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CadrPreviewCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.5, height: collectionView.frame.width/2)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmPreview.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomMovieNewCellView
        let displayingMovie = filmPreview[indexPath.row]
        return getCellOfNewMovies(cell: cell, movie: displayingMovie)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    private func getCellOfNewMovies(cell: UICollectionViewCell, movie: String) -> UICollectionViewCell {
        let backgroundImageView = UIImageView()

        if let imageUrl = URL(string: movie) {
            LoadFileHelper.loadImge(withUrl: imageUrl, view: backgroundImageView)
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

