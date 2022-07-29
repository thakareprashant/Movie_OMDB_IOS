//
//  MovieListModel.swift
//  MovieOMDB
//
//  Created by prashant thakare on 13/07/22.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let Search: [search]?
    let totalResults, `Response`: String?

    
}

// MARK: - Search
struct search: Codable {
    let Title, Year, imdbID: String?
    let `Type`: String?
    let Poster: String?

    
}


