//
//  ApiSession.swift
//  YoutubeKit
//
//  Created by Ryo Ishikawa on 12/30/2017
//

import Foundation

public class ApiSession {
    
    public static let shared = ApiSession()
    
    private init() {}
    
    public func send<T: Requestable>(_ request: T, closure: @escaping (Result<T.Response, ApiError>) -> Void) {
        
        let urlRequest = request.makeURLRequest()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, rawResponse, error) in
            
            let response = ApiResponse(data: data, response: rawResponse)

            // If the dataTask error is occured.
            if let error = error {
                closure(.failed(ApiError.unexpected(error,response)))
                return
            }
            
            // Decodable must have data length at least.
            guard let data = data else {
                closure(.failed(ApiError.empytDate(response)))
                return
            }
            
            // Decoding the response from `data` and handle DecodingError if occured.
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.Response.self, from: data)
                DispatchQueue.main.async {
                    closure(.success(result))
                }
            } catch {
                closure(.failed(ApiError.objectMapping(error,response)))
            }
        }
        
        task.resume()
    }
}

//extension URLResponse {
//
//    public func filter(statusCodes: ClosedRange<Int>) throws -> Response {
//        guard statusCodes.contains(statusCode) else {
//            throw MoyaError.statusCode(self)
//        }
//        return self
//    }
//
//}

