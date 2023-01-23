//
//  ContentView.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import SwiftUI

struct ContentView: View {
    

    @State var newsList: [Article] = []
    
    var body: some View {
        TabView {
                SearchTabView()
                    .tabItem {
                        Label("Search News", systemImage: "magnifyingglass")
                    }
            
                FavoriteView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared

    
    static var previews: some View {
        ContentView(newsList: Article.previewData)
            .environmentObject(bookmarkVM)
    }
}
