//
//  BalinkNewsApiApp.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import SwiftUI

@main
struct BalinkNewsApiApp: App {
    @StateObject var bookmarkVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkVM)
        }
    }
}
