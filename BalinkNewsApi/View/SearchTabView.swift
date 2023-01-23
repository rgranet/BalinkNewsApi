//
//  SearchTabView.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import SwiftUI

struct SearchTabView: View {
    @StateObject var searchViewModel = ArticleSearchViewModel()
    private var articles: [Article] {
        if case .success(let articles) = searchViewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    
    var body: some View {
        NavigationView {
            
            ArticleListView(articles: articles)
                .searchable(text: $searchViewModel.searchQuery)
                .onSubmit(of: .search, search)
                .navigationTitle("NewsAPI")
        }
    }
    
    
    private func search() {
        Task {
            await searchViewModel.searchArticle()
        }
    }
}




struct SearchTabView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        SearchTabView()
            .environmentObject(bookmarkVM)
    }
}
