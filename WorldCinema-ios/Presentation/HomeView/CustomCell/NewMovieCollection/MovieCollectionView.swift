//
//  MovieCollectionView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 12.04.2023.
//


import Foundation
import UIKit

class MovieCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    private var filmsCount: [MovieResponse]
    
    
    
    lazy var movieNewCollectionView: UICollectionView = { [unowned self] in
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red

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
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomMovieNewCellView
        cell.backgroundColor = .red
        return cell
    }
}