//
//  ApiService.swift
//  iomorinPW2
//
//  Created by Илья Морин on 07.12.2022.
//

import Foundation

final class ApiService {
    static let shared = ApiService()
    
    struct Constants {
        static let topHeadlinesURL = URL (string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=725e3541e5024b2b8197562bc9c9b80b")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article],Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print ("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
            
        }
        task.resume()
    }
}

// Models

struct APIResponse: Codable{
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
