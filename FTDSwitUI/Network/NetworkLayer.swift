//
//  NetworkLayer.swift
//  FTDSwitUI
//
//  Created by Jon E on 11/5/21.
//

import Foundation

class NetworkLayer {
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, FTDAlert>) -> ()) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.allHTTPHeaderFields = endpoint.headers
        urlRequest.httpMethod = endpoint.method
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.invalidResponse))
                return
            }
        }.resume()
    }
}
