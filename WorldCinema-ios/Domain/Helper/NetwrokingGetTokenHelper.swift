//
//  NetwrokingGetTokenHelper.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 01.04.2023.
//

import Alamofire
import Foundation

class NetwrokingGetTokenHelper {
    static func getHeadersWithBearer(token: String) -> HTTPHeaders {
        var headers: HTTPHeaders = NetworkingModel.headers
        headers.add(.authorization(bearerToken: token))

        return headers
    }
}
