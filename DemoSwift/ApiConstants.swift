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
    
    case unexpected(Error, ApiResponse)
    case empytDate(ApiResponse)
    case objectMapping(Error, ApiResponse)
    case statusCode(ApiResponse)
    
    var response: ApiResponse {
        switch self {
        case .unexpected(_, let resp):
            return resp
        case .empytDate(let resp):
            return resp
        case .objectMapping(_, let resp):
            return resp
        case .statusCode(let resp):
            return resp
        }
    }
    
    
    
}

public struct BaseModel: Codable {
    var Status: Int?
    var Code: Int?
    var Name: String?
    var Message: String?
}
