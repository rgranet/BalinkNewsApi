//
//  ArticleView.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import SwiftUI


struct ArticleView: View {
    @State var article: Article
    @EnvironmentObject var bookmarkVM: ArticleBookmarkViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: article.imageURL) { phase in
                    switch phase {
                    case .empty :
                        ProgressView()
                                                   
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    case .failure(_):
                        HStack {
                            Spacer()
                            Image(systemName: "photo")
                                .imageScale(.large)
                            Spacer()
                        }
                        
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(minHeight: 200, maxHeight: 300)
                
                Text(article.title)
                    .background()
                    .font(.title)
                    .bold()
                    .padding()
               
                HStack {
                    Button {
                        toggleFavorite(for: article)
                    } label: {
                        if bookmarkVM.isBookmarked(for: article) {
//                            Label("remove for your favorites", systemImage: "star.fill")
                            Image(systemName: "star.fill")
                        } else {
//                            Label("Add to your favorites", systemImage: "star")
                            Image(systemName: "star")
                        }
                    }
                    
                    Text("Author : \(article.authorText)")
                        .font(.headline)
                }
                
                Text(article.date)
                
                
                Text(article.contentText)
                    .padding()
                
                Link(destination: article.urlToArticle) {
                    Label("Read the article", systemImage: "network")
                }
            }
        }
    }
    private func toggleFavorite(for article: Article) {
        if bookmarkVM.isBookmarked(for: article) {
            bookmarkVM.removeBookmark(for: article)
        } else {
            bookmarkVM.addBookmark(for: article)
        }
    }
    
}

struct ArticleView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared


    
    static var previews: some View {
        ArticleView(article: .previewData[0])
            .environmentObject(bookmarkVM)
    }
}
