//
//  FavoriteView.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var bookmarkVM: ArticleBookmarkViewModel
    
    
    var body: some View {
        let articles = bookmarkVM.bookmarks
        NavigationView {
            if articles.isEmpty {
                VStack {
                    Text("No favorite articles added")
                        .padding()
                        .foregroundColor(.red)
                        .bold()
                    Image(systemName: "bookmark.slash")
                        .font(.title)
                        
                }
                .navigationTitle("Your Favorites")
            } else {
                ArticleListView(articles: articles)
                    .navigationTitle("Your Favorites")
            }
        }
             
    }
}

struct FavoriteView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared

    
    static var previews: some View {
        FavoriteView()
            .environmentObject(bookmarkVM)
    }
}
