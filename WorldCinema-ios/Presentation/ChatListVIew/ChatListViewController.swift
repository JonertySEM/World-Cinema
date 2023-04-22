//
//  ChatListViewController.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import UIKit

class ChatListViewController: UIViewController {
    
    var viewModel: ChatListViewModel
    
    private var chatArray = [ChatResponse]()
    
    
    
    init(viewModel: ChatListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        createUI()
        
    }
    
    lazy var chatTableList = ChatListTableView(chatList: chatArray)
    
    private func createUI(){
        view.addSubview(chatTableList)
        
        chatTableList.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

}
