//
//  KeyChainRepository.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation

protocol KeychainRepository {
    func getValueByKey(_ key: String, completion: ((Result<String, Error>) -> Void)?)
    func saveValueByKey(_ key: String, value: String, completion: ((Result<Void, Error>) -> Void)?)
}
