//
//  ArticleSearchViewModel.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var searchQuery = ""
    @Published var languageQuery = ""
    private let newsApi = NewsApi.shared
    
    @Published var phase: DataFetchPhase<[Article]> = .empty
    static let shared = ArticleSearchViewModel()
    
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        if searchQuery.isEmpty { return }
        
        
        do {
            let articles = try await newsApi.search(for: searchQuery)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}


enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
}
