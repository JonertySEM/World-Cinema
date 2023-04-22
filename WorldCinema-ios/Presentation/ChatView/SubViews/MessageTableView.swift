//
//  MessageTableView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import UIKit

class MessageTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    lazy var chatTableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: .zero)
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .green
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let chatList: [ChatMessageResponse]
    private let chatTapClosure: (([MovieResponse?]) -> Void)?

    init(
        chatList: [ChatMessageResponse],
        chatTapClosure: (([MovieResponse?]) -> Void)? = nil
    ) {
        self.chatList = chatList
        self.chatTapClosure = chatTapClosure
        super.init(frame: .zero)

        addSubview(chatTableView)

        chatTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        chatTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        chatTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        chatTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MessageTableView {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = R.font.sfProTextRegular(size: 12)
        label.text = chatList[section].creationDateTime.uppercased()
        label.textAlignment = .center
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatList[section].text.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as! MessageTableViewCell
                                        
        return cell
    }
}
