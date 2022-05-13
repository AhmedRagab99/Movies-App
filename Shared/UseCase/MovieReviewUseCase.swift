//
//  MovieReviewUseCase.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import Foundation

protocol MovieReviewsUseCaseProtocol{
    func getMovieReviews(movieId:String) async throws -> [ReviewsModelResult]
}

class MovieReviewsUseCase:MovieReviewsUseCaseProtocol{
    
    let movieReviewsRepo:MovieReviewRepoProtocol?
    
    init(movieReviewsRepo:MovieReviewRepoProtocol) {
        self.movieReviewsRepo = movieReviewsRepo
    }
    func getMovieReviews(movieId: String) async throws -> [ReviewsModelResult] {
        if let movieReviewsRepo = movieReviewsRepo {
            do {
                let movieReviews = try await movieReviewsRepo.getMovieReviews(movieId: movieId)
                return movieReviews
            } catch  {
                throw error
            }
        }
        return []
    }
    
    
}
