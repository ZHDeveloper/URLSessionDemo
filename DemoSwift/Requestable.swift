//
//  Requestable.swift
//  YoutubeKit
//
//  Created by Ryo Ishikawa on 12/30/2017
//

import Foundation

public protocol Requestable {
    
    // The response of `Requestable` expects JSON object.
    associatedtype Response: Decodable
    
    // The base of URL.
    var baseURL: URL { get }
    
    // The path of URL.
    var path: String { get }
    
    // The header field of HTTP.
    var headerField: [String: String] { get }
    
    // If the request needs OAuth authorization, this will set `true`. The default value is `false`.
    var isAuthorizedRequest: Bool { get }
    
    // Set http method. Example: `.get`
    var httpMethod: HTTPMethod { get }
    
    // The http body parameter, The default value is `nil`.
    var httpBody: Data? { get }
    
    // Additional query paramters for URL, The default value is `[:]`.
    var queryParameters: [String: Any] { get }
}

//https://yuetao.66boss.com/v1/public/checkupdate

public extension Requestable {
    
    public var baseURL: URL {
        return URL(string: "https://yuetao.66boss.com/v1")!
    }
    
    public var queryParameters: [String: Any] {
        return [:]
    }
    
    public var headerField: [String: String] {
        let header: [String: String] = [:]
        return header
    }
    
    public var isAuthorizedRequest: Bool {
        return false
    }
    
    public var httpBody: Data? {
        return nil
    }
    
    public func makeURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        let header: [String: String] = headerField
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        header.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = httpBody {
            urlRequest.httpBody = body
        }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return urlRequest
        }
        
        let keyParams: [String: Any] = queryParameters
        
        urlComponents.query = keyParams
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        
        urlRequest.url = urlComponents.url
        
        return urlRequest
    }
}

