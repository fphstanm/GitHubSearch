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
    
    static func getRepositories(withString string: String, completion: @escaping (Repositories?) -> Void) {
        let urlString = "https://api.github.com/search/repositories?q=" + string
        guard let url = URL(string: urlString) else { return completion(nil) }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return completion(nil) }
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(Repositories.self, from: data)
                completion(result)
            } catch {
                completion(nil)
            }
        }
        task?.resume()
    }
    
}
