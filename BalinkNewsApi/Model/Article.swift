//
//  Article.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import Foundation

struct Article: Codable, Equatable, Identifiable {
    
    let id = UUID()
    
    
    let source : Source
    
    let author: String?
    var authorText: String {
        author ?? source.name
    }
    
    let title: String
    
    let description: String?
    var descriptionText: String {
        description ?? ""
    }
    
    let url: String
    var urlToArticle: URL {
        URL(string: url)!
    }
        
    let content: String?
    var contentText: String {
        content ?? ""
    }
    let publishedAt: Date
    var date: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: publishedAt)
    }
    
    let urlToImage: URL?
    var imageURL: URL? {
        guard let urlToImage = urlToImage else { return nil }
        return urlToImage
    }
    
    static var previewData: [Article] {
        let previewDataUrl = Bundle.main.url(forResource: "newsexample", withExtension: "json")
        let data = try! Data(contentsOf: previewDataUrl!)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        
        return apiResponse.articles ?? []
    }
    
}

struct Source: Codable, Equatable {
    let id: String?
    
    var idText: String {
        id ?? ""
    }
    
    let name: String
}
