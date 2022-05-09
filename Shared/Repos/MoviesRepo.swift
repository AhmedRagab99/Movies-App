//
//  MoviesRepo.swift
//  MoviesApp (iOS)
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import Foundation

protocol MoviesRepoProtocol{
    mutating  func fetchMovies(from:MovieListEndPoints) async throws -> [Movie]
//    mutating func fetchAllMovies() async throws -> [MovieSection]
}


struct MoviesRepo:MoviesRepoProtocol{
    // MARK: - properties
    private lazy var movieBaseAppStore:MoviesAppBaseStoreProtocol = MoviesAppBaseStore()
    private let baseEndPointUrl = "\(Utils.BaseApiUrl)/movie/"
    
    // MARK: Functions
    mutating func fetchMovies(from endpoint: MovieListEndPoints) async  throws -> [Movie] {
        guard let url = URL(string: "\(baseEndPointUrl)\(endpoint.rawValue)") else {  throw MoviesAppError.invalidEndPoints}
        do{
            let movies:MovieResponse =  try await self.movieBaseAppStore.loadURLAndDecode(url: url, params: nil)
            return movies.results
        } catch{
            throw MoviesAppError.serializationError
        }
        
    }
    
//    mutating func fetchAllMovies() async throws -> [MovieSection] {
//        let sections  = withThrowingTaskGroup(of: Movie.self, body: <#T##(inout ThrowingTaskGroup<Sendable, Error>) async throws -> GroupResult#>)
//    }
}


