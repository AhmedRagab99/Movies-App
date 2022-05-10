//
//  MoviesViewModel.swift
//  MoviesApp
//  Created by Ahmed Ragab on 09/05/2022.
//

import Foundation

class MoviesViewModel:ObservableObject{
    @Published var phaseState:DataFetchPhase<[MovieSection]> = .empty
    private  var movieUseCase:MoviesUseCaseProtocol?
    
    init(movieUseCase:MoviesUseCaseProtocol) {
        self.movieUseCase = movieUseCase
    }
    var sections: [MovieSection] {
        phaseState.value ?? []
    }
    
    
    
    
    
    @MainActor func loadMoviesFromAllEndpoints(invalidateCache:Bool) async {
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
    
    @MainActor func fetchMovies(endPoint:MovieListEndPoints) async {
        self.phaseState = .empty
        if var movieUseCase = movieUseCase {
            
            do{
                let movies = try await movieUseCase.fetchMovies(from: endPoint)
                
                self.phaseState = .success([MovieSection(movies: movies, endpoint: endPoint)])
            } catch (let error){
                self.phaseState = .failure(error)
                print("error from view model",error.localizedDescription)
            }
        }
    }
}

