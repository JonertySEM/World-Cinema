//
//  ProfileRepositoryImpl.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 09.04.2023.
//

import Alamofire
import Foundation

class ProfileRepositoryImpl: ProfileRepository {
    private let requestInterceptor: RequestInterceptor

    private static let url = NetworkingModel.baseUrl

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

    func getProfileData(token: String, completion: ((Result<ProfileResponse, Error>) -> Void)?) {
        AF.request(
            Self.url + NetworkingModel.profile,
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

    func uploadAvatarPhoto(token: String, imageData: Data?, completion: ((Result<VoidResponse, Error>) -> Void)?) {
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization": "Bearer \(token)"
        ]
        AF.upload(multipartFormData: { multiplaformData in
                      if let data = imageData {
                          multiplaformData.append(data, withName: "imagename", fileName: "imagename.jpg", mimeType: "image/jpeg")
                      }
                  },
                  to: Self.url + NetworkingModel.profile + NetworkingModel.avatar,
                  headers: headers,
                  interceptor: requestInterceptor)

            .validate()
            .response { [self] result in
                result.processResult(
                    jsonDecoder: jsonDecoder,
                    completion: completion
                )
            }
    }
}
