//
//  MoviesViewModel.swift
//  MoviesApp (iOS)
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import Foundation


enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

class MoviesViewModel:ObservableObject{
    @Published var movies:[Movie] = []
    @Published var phaseState:DataFetchPhase<[Movie]> = .empty
    private lazy var movieRepo:MoviesRepoProtocol = MoviesRepo()
    
    @MainActor func fetchMovies(endPoint:MovieListEndPoints) async {
        self.phaseState = .empty
        do{
            let movies = try await self.movieRepo.fetchMovies(from: endPoint)
            self.movies = movies
            self.phaseState = .success(movies)
        } catch (let error){
            self.phaseState = .failure(error)
            print("error from view model",error.localizedDescription)
        }
    }
}
