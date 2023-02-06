//
//  APICaller.swift
//  NewsApp
//
//  Created by GIORGI's MacPro on 06.02.23.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlines = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3efce674949743fabea864ee3d325510")
    }
    
    private init() {}
    
    public func getTopNews(completion: @escaping (Result<[Articles], Error>) -> Void) {
        guard let url = Constants.topHeadlines else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(APIResponse.self, from: data)
                        
                        print("Articles: \(result.articles.count)")
                        completion(.success(result.articles))
                    }
                    
                    catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}

struct APIResponse: Codable {
    let articles: [Articles]
}

struct Articles: Codable {
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
