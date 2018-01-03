//
//  HttpMethod.swift
//  YoutubeKit
//
//  Created by Ryo Ishikawa on 12/30/2017
//

import Foundation

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum Result<T, E> {
    case success(T)
    case failed(E)
}

public struct ApiResponse {
    
    var date: Data?
    var urlResponse: URLResponse?
    
    init(data: Data?, response: URLResponse?) {
        self.date = data
        self.urlResponse = response
    }
}

public enum ApiError: Error {
    case unexpected(Swift.Error, ApiResponse)
    case empytDate(ApiResponse)
    case objectMapping(Swift.Error, ApiResponse)
    case encodableMapping(Swift.Error, ApiResponse)
    case statusCode(ApiResponse)
}

public struct BaseModel: Codable {
    var Status: Int?
    var Code: Int?
    var Name: String?
    var Message: String?
}
