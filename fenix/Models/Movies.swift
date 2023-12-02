//
//  Movies.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
