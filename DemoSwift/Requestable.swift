//
//  Requestable.swift
//  DemoSwift
//
//  Created by ZhiHua Shen on 2018/1/2.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import Foundation

public protocol Requestable {
    
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var headerField: [String: String] { get }
    
    var httpMethod: HTTPMethod { get }
    
    var httpBody: Data? { get }
    
    var queryParameters: [String: Any] { get }
}

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

