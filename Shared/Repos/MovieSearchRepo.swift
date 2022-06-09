//
//  MovieRepo.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import Foundation

protocol MovieSearchRepoProtocol{
    func searchMovie(query:String) async throws -> [Movie]
}

class MovieSearchRepo:MovieSearchRepoProtocol{
    private let searchApiUrl = "\(Utils.BaseApiUrl)/search/movie"
    
    private lazy var movieStore:MoviesAppBaseStore = MoviesAppBaseStore()
    func searchMovie(query: String) async throws -> [Movie] {
        guard let url = URL(string: "\(searchApiUrl)") else { throw MoviesAppError.invalidEndPoints}
        
        do{
            let movies:MovieResponse =  try await movieStore.loadURLAndDecode(url: url, params: ["query":query])
            
            return movies.results ?? []
        } catch{
            throw error
        }
        
    }
}
