//
//  MoviesViewModel.swift
//  MoviesApp
//  Created by Ahmed Ragab on 09/05/2022.
//

import Foundation

class MoviesViewModel:ObservableObject{
    @Published var phaseState:DataFetchPhase<[MovieSection]> = .empty
    private  var movieRepo:MoviesRepoProtocol?
    
    init(movieRepo:MoviesRepoProtocol) {
        self.movieRepo = movieRepo
    }
    var sections: [MovieSection] {
        phaseState.value ?? []
    }
    
    private func fetchMoviesFromEndpoint(_ endpoint: MovieListEndPoints) async -> Result<MovieSection, Error> {
        if var movieRepo = movieRepo {
            
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
    
     private func fetchMoviesFromEndpoints(
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
    
    @MainActor func loadMoviesFromAllEndpoints(invalidateCache:Bool) async {
        if Task.isCancelled { return }
        if case .success = phaseState , !invalidateCache{
            return
        }

        phaseState = .empty
        
        do {
            let sections = try await fetchMoviesFromEndpoints()
            if Task.isCancelled { return }
            phaseState = .success(sections)
        } catch {
            if Task.isCancelled { return }
            phaseState = .failure(error)
        }
        
    }
    
    @MainActor func fetchMovies(endPoint:MovieListEndPoints) async {
        self.phaseState = .empty
        if var movieRepo = movieRepo {

            do{
                let movies = try await movieRepo.fetchMovies(from: endPoint)
                
                self.phaseState = .success([MovieSection(movies: movies, endpoint: endPoint)])
            } catch (let error){
                self.phaseState = .failure(error)
                print("error from view model",error.localizedDescription)
            }
        }
    }
}

