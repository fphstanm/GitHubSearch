//
//  NetworkService.swift
//  GitHubSearch
//
//  Created by Philip on 10.11.2020.
//

import Foundation

class NetworkService {
    
    static let shared = NetService()

    private init() {}
    
    private static var task: URLSessionDataTask? {
        willSet {
            task?.cancel()
        }
    }
    
    static func getRepositories(withString string: String, completion: @escaping (Repositories?, NSError?) -> Void) {
        let urlString = "https://api.github.com/search/repositories?q=" + string
        guard let url = URL(string: urlString) else { return completion(nil, nil) }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard error r== nil else { return completion(nil, error as NSError?) }
            guard let data = data else { return completion(nil, nil) }
            guard let response = response else { return completion(nil, NSError()) }
            guard checkError(response: response) == nil else {
                return completion(nil, checkError(response: response))
            }
            
            do {
                let result = try JSONDecoder().decode(Repositories.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, NSError())
            }
            
        }
        task?.resume()
    }
    
    private static func checkError(response: URLResponse) -> NSError? {
        guard let httpResponse = response as? HTTPURLResponse else { return NSError() }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            return NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)
        }
        
        return nil
    }
    
}
