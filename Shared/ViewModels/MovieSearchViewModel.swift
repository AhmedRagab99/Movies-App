//
//  MovieSearchViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import Foundation
import Combine

@MainActor class MovieSearchViewModel:ObservableObject{
    
    @Published var phaseState:DataFetchPhase<[Movie]> = .empty
    @Published var query = ""
    private var cancellables = Set<AnyCancellable>()
    
    var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var movieSearchUseCase:MovieSearchUseCaseProtocol?
    
    init(movieSearchUseCase:MovieSearchUseCaseProtocol) {
        self.movieSearchUseCase = movieSearchUseCase
    }
    
    
     func startObserve() {
        guard cancellables.isEmpty else { return }
        
        $query
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .sink { [weak self] _ in
                self?.phaseState = .empty
            }
            .store(in: &cancellables)
        
        $query
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { query in
                Task { [weak self] in
                    guard let self = self else { return }
                    await self.searchMovie(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
     func searchMovie(query:String) async {
        if Task.isCancelled { return }
        
        phaseState = .empty
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            return
        }

        if let movieSearchUseCase = movieSearchUseCase {
            do {
                if Task.isCancelled { return }
                guard trimmedQuery == self.trimmedQuery else { return }
                let movies  = try await movieSearchUseCase.searchMovie(query: query)
                phaseState = .success(movies)
            } catch  {
                if Task.isCancelled { return }
                guard trimmedQuery == self.trimmedQuery else { return }
                phaseState = .failure(error)
            }
        }
        
    }
}
