//
//  MovieReviewsViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import Foundation


class MovieReviewsViewModel:ObservableObject{
    @Published var phaseState:DataFetchPhase<[ReviewsModelResult]> = .empty
    private let movieReviewUseCase:MovieReviewsUseCaseProtocol?
    init(movieReviewUseCase:MovieReviewsUseCaseProtocol) {
        self.movieReviewUseCase = movieReviewUseCase
    }
    
   @MainActor func  getMovieReviews(movieId:String) async {
        if Task.isCancelled { return }
        phaseState = .empty
        if let movieReviewUseCase = movieReviewUseCase {
            do {
                if Task.isCancelled { return }
                let movieReviews  = try await movieReviewUseCase.getMovieReviews(movieId: movieId)
                phaseState = .success(movieReviews)
            } catch  {
                if Task.isCancelled { return }
                phaseState = .failure(error)
            }
        }
    }
}

