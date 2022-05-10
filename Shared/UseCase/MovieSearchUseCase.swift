//
//  MovieSearchUseCase.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import Foundation

protocol MovieSearchUseCaseProtocol{
    func searchMovie(query:String) async throws -> [Movie]
}


class MovieSearchUseCase:MovieSearchUseCaseProtocol{
    let movieSearchRepo:MovieSearchRepoProtocol?
    init(movieSearchRepo:MovieSearchRepoProtocol) {
        self.movieSearchRepo = movieSearchRepo
    }
    func searchMovie(query: String) async throws -> [Movie] {
        if let movieSearchRepo = movieSearchRepo {
            do {
                let movies = try await movieSearchRepo.searchMovie(query: query)
                return movies
            } catch  {
                throw error
            }
        }
        return []
    }
}
