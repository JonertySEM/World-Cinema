//
//  MovieCollectionView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//

import Foundation
import UIKit

class MovieCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    lazy var movieNewCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionFilmsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionFilmsView.backgroundColor = GetHexColorHelper().hexStringToUIColor(hex: "#150D0B")
        collectionFilmsView.delegate = self
        collectionFilmsView.dataSource = self
        collectionFilmsView.translatesAutoresizingMaskIntoConstraints = false
        collectionFilmsView.register(CustomMovieNewCellView.self, forCellWithReuseIdentifier: "cell")

        return collectionFilmsView
    }()

    private let movieList: [MovieResponse]
    private let movieTapClosure: ((MovieResponse) -> Void)?

    init(
        movieList: [MovieResponse],
        movieTapClosure: ((MovieResponse) -> Void)? = nil

    ) {
        self.movieList = movieList
        self.movieTapClosure = movieTapClosure
        super.init(frame: .zero)

        addSubview(movieNewCollectionView)

        movieNewCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        movieNewCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        movieNewCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        movieNewCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.5, height: collectionView.frame.width/2)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomMovieNewCellView
        let displayingMovie = movieList[indexPath.row]
        return getCellOfNewMovies(cell: cell, movie: displayingMovie)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieTapClosure?(movieList[indexPath.item])
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
