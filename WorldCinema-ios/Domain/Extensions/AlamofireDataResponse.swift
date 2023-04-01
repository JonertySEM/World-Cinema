//
//  AlamofireDataResponse.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 27.03.2023.
//
import Alamofire
import Foundation

extension AFDataResponse {
    private func processError() -> Error {
        do {
            if let data = data,
               let responseAsDictionary =
               try JSONSerialization.jsonObject(
                   with: data, options: .allowFragments
               ) as? [String: [String]]
            {
                let errorMessage = responseAsDictionary.keys
                    .sorted(by: <)
                    .map { responseAsDictionary[$0]! }
                    .reduce("") { $0 + String($1.joined(separator: "\n") + "\n") }

                return NSError.createErrorWithLocalizedDescription(errorMessage)
            } else {
                return NetworkingEnums.unableToGetData
            }
        } catch {
            return NetworkingEnums.unableToGetData
        }
    }

    func processResult<T: Codable>(
        jsonDecoder: JSONDecoder,
        completion: ((Result<T, Error>) -> Void)?
    ) {
        if let underlyingError = error?.asAFError?.underlyingError {
            completion?(.failure(underlyingError))

            return
        }

        if self.response?.statusCode == NetworkingModel.wrongDataStatusCode ||
            self.response?.statusCode == NetworkingModel.userAlreadyExistsStatusCode
        {
            completion?(.failure(processError()))

            return
        }

        guard let response = data else {
            if self.response?.statusCode == NetworkingModel.successStatusCode,
               T.self == VoidResponse.self
            {
                completion?(.success(VoidResponse() as! T))
            } else {
                completion?(.failure(NetworkingEnums.unableToGetData))
            }

            return
        }

        do {
            let decodedResponse = try jsonDecoder.decode(T.self, from: response)

            completion?(.success(decodedResponse))
        } catch {
            completion?(.failure(error))
        }
    }
}
