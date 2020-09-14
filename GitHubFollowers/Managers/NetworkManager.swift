//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/13/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared   = NetworkManager()
    let baseUrl         = "https://api.github.com/users/"
    
    private init (){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower],GFError>)-> Void){
        let endPoint    = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        guard let url   = URL(string: endPoint) else{
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder     = JSONDecoder()
                //to convert CamelCase to SnakeCase
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers   = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
}