//
//  MovieDetailModel.swift
//  MovieOMDB
//
//  Created by prashant thakare on 13/07/22.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieDetail = try? newJSONDecoder().decode(MovieDetail.self, from: jsonData)

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let Title, Year, Rated, Released: String?
    let Runtime, Genre, Director, Writer: String?
    let Actors, Plot, Language, Country: String?
    let Awards: String?
    let Poster: String?
    let Ratings: [Rating]?
    let Metascore, imdbRating, imdbVotes, imdbID: String?
    let `Type`, Dvd, BoxOffice, production: String?
    let website, response: String?

    
}

// MARK: - Rating
struct Rating: Codable {
    let Source, Value: String?

    
}
