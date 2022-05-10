//
//  MoviesUseCase.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import Foundation


protocol MoviesUseCaseProtocol{
    func fetchMoviesFromEndpoints(
      _ endpoints: [MovieListEndPoints]) async throws -> [MovieSection]
    func fetchMovies(from endpoint: MovieListEndPoints) async  throws -> [Movie]
}


class MoviesUseCase:MoviesUseCaseProtocol{
    let movieRepo:MoviesRepoProtocol?
    
    init(movieRepo:MoviesRepoProtocol) {
        self.movieRepo = movieRepo
    }
    
    func fetchMovies(from endpoint: MovieListEndPoints) async  throws -> [Movie] {
       
       do{
           if let movieRepo = movieRepo {
               let movies:[Movie] =  try await movieRepo.fetchMovies(from: endpoint)
               return movies
           }
           
       } catch{
           throw error
       }
        return []
   }
    
    func fetchMoviesFromEndpoint(_ endpoint: MovieListEndPoints) async -> Result<MovieSection, Error> {
        if let movieRepo = movieRepo {
            
            do {
                let movies = try await movieRepo.fetchMovies(from: endpoint)
                return .success(.init(
                    movies: movies,
                    endpoint: endpoint)
                )
            } catch {
                return .failure(error)
            }
        }
        return .failure(MoviesAppError.geniricError)
    }
    
     func fetchMoviesFromEndpoints(
       _ endpoints: [MovieListEndPoints] = MovieListEndPoints.allCases) async throws -> [MovieSection] {
       let results: [Result<MovieSection, Error>] = await withTaskGroup(of: Result<MovieSection, Error>.self) { group in
           for endpoint in endpoints {
               group.addTask { await self.fetchMoviesFromEndpoint(endpoint) }
           }
           
           var results = [Result<MovieSection, Error>]()
           for await result in group {
               results.append(result)
           }
           return results
       }
       
       var movieSections = [MovieSection]()
       var errors = [Error]()
       
       results.forEach { result in
           switch result {
           case .success(let movieSection):
               movieSections.append(movieSection)
           case .failure(let error):
               errors.append(error)
           }
       }
       
       if errors.count == results.count, let error = errors.first {
           throw error
       }
       
       return movieSections.sorted { $0.endpoint.sortIndex < $1.endpoint.sortIndex }

   }
}
