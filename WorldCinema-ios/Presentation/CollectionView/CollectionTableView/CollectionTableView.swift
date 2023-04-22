//
//  CollectionTableView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import UIKit


class CollectionTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    lazy var collectionTableView: UITableView = { [unowned self] in
       let tableView = UITableView()
        
        return tableView
    }()
    
    
    private let collectionList: [CollectionResponse]
    private let episodeTapClosure: (([MovieResponse?]) -> Void)?

    init(
        collectionList: [CollectionResponse],
        episodeTapClosure: (([MovieResponse?]) -> Void)? = nil
    ) {
        self.collectionList = collectionList
        self.episodeTapClosure = episodeTapClosure
        super.init(frame: .zero)

        addSubview(collectionTableView)

        collectionTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CollectionTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomCollectionTableCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        episodeTapClosure("")
    }
}
