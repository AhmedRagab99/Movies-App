//
//  MoviesViewModel.swift
//  MoviesApp
//  Created by Ahmed Ragab on 09/05/2022.
//

import Foundation

@MainActor class MoviesViewModel:ObservableObject{
    @Published var phaseState:DataFetchPhase<[MovieSection]> = .empty
    @Published var similarMoviesState:DataFetchPhase<[Movie]> = .empty
    
//    @Published var movie
    private  var movieUseCase:MoviesUseCaseProtocol?
    
    init(movieUseCase:MoviesUseCaseProtocol) {
        self.movieUseCase = movieUseCase
    }
    var sections: [MovieSection] {
        phaseState.value ?? []
    }
    
    func fetchSimilarMovies(movieId: String) async   {
        if Task.isCancelled { return }
        similarMoviesState = .empty
        if let movieUseCase = movieUseCase {
            do {
                if Task.isCancelled { return }
                
                let movies  = try await movieUseCase.fetchSimilarMovies(movieId: movieId)
                similarMoviesState = .success(movies)
            } catch  {
                if Task.isCancelled { return }
                similarMoviesState = .failure(error)
            }
        }
    }
    
     func loadMoviesFromAllEndpoints(invalidateCache:Bool) async {
        if Task.isCancelled { return }
        if case .success = phaseState , !invalidateCache{
            return
        }
        
        phaseState = .empty
        
        do {
            let sections = try await movieUseCase?.fetchMoviesFromEndpoints(MovieListEndPoints.allCases)
            if Task.isCancelled { return }
            if let sections = sections{
                phaseState = .success(sections)
            }
        } catch {
            if Task.isCancelled { return }
            phaseState = .failure(error)
        }
        
    }
    
     func fetchMovies(invalidateCache:Bool,endPoint:MovieListEndPoints) async {
        if Task.isCancelled { return }
        self.phaseState = .empty
        if let movieUseCase = movieUseCase {
            
            if case .success = phaseState , !invalidateCache{
                return
            }
            do{
                if Task.isCancelled { return }
                let movies = try await movieUseCase.fetchMovies(from: endPoint)
                
                self.phaseState = .success([MovieSection(movies: movies, endpoint: endPoint)])
                
            } catch (let error){
                if Task.isCancelled { return }
                self.phaseState = .failure(error)
                print("error from view model",error.localizedDescription)
            }
        }
    }
}

