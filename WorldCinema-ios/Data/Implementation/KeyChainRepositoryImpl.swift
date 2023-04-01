//
//  KeyChainRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Foundation
import Alamofire
import Foundation
import KeychainAccess

class KeychainRepositoryImpl: KeychainRepository {
    private static let packageName = Bundle.main.bundleIdentifier ?? "com.hits.WorldCinema-ios"
    private let keychain = Keychain(service: packageName)

    func getValueByKey(_ key: String, completion: ((Result<String, Error>) -> Void)?) {
        do {
            guard let result = try keychain.get(key) else {
                completion?(.failure(KeychainRepositoryErrorsEnum.unableToGetSavedValue))

                return
            }

            completion?(.success(result))
        } catch {
            completion?(.failure(error))
        }
    }

    func saveValueByKey(_ key: String, value: String, completion: ((Result<Void, Error>) -> Void)?) {
        do {
            try keychain.set(value, key: key)
            completion?(.success(()))
        } catch {
            completion?(.failure(error))
        }
    }
}
