//
//  TimeEpisodeRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 19.04.2023.
//

import Alamofire
import Foundation

class TimeEpisodeRepositoryImpl: TimeEpisodesRepository {
    private static let url = NetworkingModel.baseUrl

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder,
         jsonEncoder: JSONEncoder)
    {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
    }

    func getTimePosition(token: String, episodeId: String, completion: ((Result<EpisodesTime, Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.episodes + "/\(episodeId)" + NetworkingModel.time,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token)
        ) { $0.timeoutInterval = NetworkingModel.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }

    func saveTimePosition(token: String, episodeId: String, timeRequest: EpisodesTime, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(timeRequest)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingModel.episodes + "/\(episodeId)" + NetworkingModel.time,
                method: .post,
                parameters: parametrs,
                encoding: JSONEncoding.default,
                headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token)
            ) { $0.timeoutInterval = NetworkingModel.timeout }
                .validate()
                .response { [self] result in
                    result.processResult(jsonDecoder: jsonDecoder,
                                         completion: completion)
                }
        } catch {
            completion?(.failure(error))
        }
    }
}
