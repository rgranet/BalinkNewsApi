//
//  NewsAPIResponse.swift
//  BalinkNewsApi
//
//  Created by Ruben Granet on 22/01/2023.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    //If there is an error message
    let code: String?
    let message: String?
}
