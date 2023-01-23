//
//  NewsApi.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import Foundation

struct NewsApi {
    
    static let shared = NewsApi()
    
    private let apiKey = "df45dd02b6894053b4fd613e907f6858"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        var apiResult: [Article] = []
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Bad Response")
            return apiResult
        }
        
        
        if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) || (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            apiResult = apiResponse.articles ?? []
        } else {
            print("An error occured")
        }
        
        return apiResult
    }
    
    
    
    
    
    func search(for query: String) async throws -> [Article] {
        try await fetchArticles(from: generateSearchURL(from: query)!)
    }
    
    private func generateSearchURL(from query: String) -> URL? {
        var url = "https://newsapi.org/v2/everything?"
        url += "q=\(query)"
        url += "&apiKey=\(apiKey)"
        
        return URL(string: url) ?? URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=df45dd02b6894053b4fd613e907f6858")
    }
}
