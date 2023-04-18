//
//  EpisodePreviewCollectionView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Foundation
import UIKit

class EpisodePreviewCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    lazy var episodePreviewCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tagCollectionView.backgroundColor = .black
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.register(CustomEpisodePreviewCell.self, forCellWithReuseIdentifier: "cell")

        return tagCollectionView
    }()

    private let episodeList: [EpisodesResponse]

    init(
        episodeList: [EpisodesResponse]

    ) {
        self.episodeList = episodeList
        super.init(frame: .zero)

        addSubview(episodePreviewCollectionView)

        episodePreviewCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        episodePreviewCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        episodePreviewCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        episodePreviewCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EpisodePreviewCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/4.2)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomEpisodePreviewCell
        let displayingMovie = episodeList[indexPath.row]

        if let imageUrl = URL(string: displayingMovie.preview) {
            LoadFileHelper.loadImge(withUrl: imageUrl, view: cell.previewEpisode)
        }

        cell.titleEpisode.text = displayingMovie.name
        cell.titleEpisode.sizeToFit()
        cell.descripitonEpisode.text = displayingMovie.description
        cell.descripitonEpisode.sizeToFit()
        
        if let year = displayingMovie.year {
            cell.yearEpisode.text = String(year)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // movieTapClosure?(movieList[indexPath.item])
    }
}
