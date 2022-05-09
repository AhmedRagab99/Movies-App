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
