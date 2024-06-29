//
//  Movie.swift
//  MovieList
//
//  Created by MACBOOK PRO on 29/6/2024.
//

import Foundation


struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let originalLanguage: String
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
