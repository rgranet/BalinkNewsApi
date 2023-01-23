//
//  ArticleListView.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//
import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    @State private var selectedDate: Date = Date()
    @State private var filteredArticles: [Article] = []
    private var Sources: [String] {
        var allSources: [String] = ["All"]
        for article in articles {
            allSources.append(article.source.name)
        }
        return allSources.removingDuplicates()
    }
    @State private var selectedSource = ""
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Button("Search") {
                    filteredArticles = articles
                }
                
                HStack {
                    Text("Select the source")
                        .padding()
                    Picker("Filter by sources", selection: $selectedSource) {
                        ForEach(Sources, id: \.self) { source in
                            Text(source)
                        }
                    }.pickerStyle(.menu)
                }
                DatePicker("Search by date", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                Button("Clear Filters") {
                    filteredArticles = articles
                }
                if filteredArticles.isEmpty {
                    VStack {
                        Spacer()
                        Image(systemName: "newspaper")
                            .font(.title)
                            .padding()
                        Text("No article found.")
                            .font(.title2)
                        
                        Spacer()
                    }
                    
                }
                
                List {
                    ForEach(filteredArticles) { article in
                        VStack{
                            ArticleRowPreviewView(article: article)
                            NavigationLink {
                                ArticleView(article: article)
                            } label: {
                                Label("Read the article", systemImage: "newspaper")
                            }
                            .padding()
                            
                        }
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                }
                .listStyle(.plain)
                .onChange(of: selectedDate) { date in
                    filteredArticles = articles.filter({
                        Calendar.current.compare($0.publishedAt, to: selectedDate, toGranularity: .day) == .orderedSame
                    })
                    
                }
                .onChange(of: selectedSource) { article in
                    filteredArticles = articles.filter { $0.source.name == selectedSource }
                    if selectedSource == "All" {
                        filteredArticles = articles
                    }
                }
                .onAppear {
                    filteredArticles = articles
                }
                
            }
            
        }
    }
}

extension Date {
    
    static func from(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? Date()
        
    }
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

struct ArticleListView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    
    static var previews: some View {
        ArticleListView(articles: Article.previewData)
            .environmentObject(bookmarkVM)
    }
}
