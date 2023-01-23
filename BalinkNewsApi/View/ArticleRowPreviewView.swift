//
//  ArticleRowPreviewView.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import SwiftUI

struct ArticleRowPreviewView: View {
    
    @EnvironmentObject var bookmarkVM: ArticleBookmarkViewModel
    
    let article: Article
    var body: some View {
        
            VStack {
                Text(article.title)
                    .font(.title3)
                    .bold()
                    .padding()
                
                Text("\(article.source.name) - \(article.date)")
                    .foregroundColor(.gray)
                
                
                Text(article.descriptionText)
                    .italic()
                    .padding()
                
                
            }
        
    }
}

struct ArticlePreviewView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        ArticleRowPreviewView(article: Article.previewData[1])
            .environmentObject(bookmarkVM)
    }
}
