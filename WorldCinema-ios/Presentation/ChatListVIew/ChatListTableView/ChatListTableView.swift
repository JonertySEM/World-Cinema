//
//  ChatListTableView.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import UIKit

class ChatListTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    lazy var chatTableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: .zero)
        tableView.register(ChatListTableCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .green
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let chatList: [ChatResponse]
    private let chatTapClosure: (([MovieResponse?]) -> Void)?

    init(
        chatList: [ChatResponse],
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

extension ChatListTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatListTableCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        episodeTapClosure("")
    }
}
