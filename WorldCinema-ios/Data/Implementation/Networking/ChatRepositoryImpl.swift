//
//  ChatRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 22.04.2023.
//

import Foundation
import Alamofire

class ChatRepositoryImpl: ChatRepository {
    
    private static let url = NetworkingModel.baseWebSocket
    private let requestInterceptor: RequestInterceptor

    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(jsonDecoder: JSONDecoder,
         jsonEncoder: JSONEncoder,
         requestInterceptor: RequestInterceptor)
    {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.requestInterceptor = requestInterceptor
    }
    
    func getChatsList(token: String, completion: ((Result<[ChatResponse?], Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.chats,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token),
            interceptor: requestInterceptor
        ) { $0.timeoutInterval = NetworkingModel.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
    
    func getInfoAboutChat(token: String, chatId: String, completion: ((Result<String, Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.chats + "/\(chatId)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token),
            interceptor: requestInterceptor
        ) { $0.timeoutInterval = NetworkingModel.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
    
    func getListMessagesInChat(token: String, chatId: String, completion: ((Result<ChatMessageResponse, Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.chats + "/\(chatId)" + NetworkingModel.messages,
            method: .get,
            encoding: JSONEncoding.default,
            headers: NetwrokingGetTokenHelper.getHeadersWithBearer(token: token),
            interceptor: requestInterceptor
        ) { $0.timeoutInterval = NetworkingModel.timeout }
            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
    
    func addMessageInChat(token: String, chatId: String, text: String, completion: ((Result<ChatMessageResponse, Error>) -> Void)?) {
        do {
            let encodedParametrs = try jsonEncoder.encode(text)
            let parametrs = try JSONSerialization.jsonObject(
                with: encodedParametrs, options: .allowFragments
            ) as? [String: Any]

            AF.request(
                Self.url + NetworkingModel.chats + "/\(chatId)" + NetworkingModel.messages,
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
