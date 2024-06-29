//
//  NetworkManager.swift
//  MovieList
//
//  Created by MACBOOK PRO on 29/6/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchTrendingMovies(completion: @escaping ([Movie]?) -> Void) {
        let url = URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(movieResponse.results)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (Movie?) -> Void) {
        let url = URL(string: "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(movie)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
