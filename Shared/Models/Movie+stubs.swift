//
//  Movie+stubs.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import Foundation

extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "Movie-list")
        return response!.results ?? []
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
    
}


extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}

extension MovieSection {
    
    static var stubs: [MovieSection] {
        
        let stubbedMovies = Movie.stubbedMovies
        return MovieListEndPoints.allCases.map {
            MovieSection(movies: stubbedMovies.shuffled(), endpoint: $0)
        }
    }
    
}

