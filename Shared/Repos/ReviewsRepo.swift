//
//  ReviewsRepo.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 13/05/2022.
//

import Foundation

protocol MovieReviewRepoProtocol{
    func getMovieReviews(movieId:String) async throws -> [ReviewsModelResult]
}

class MovieReviewRepo:MovieReviewRepoProtocol{
    private  var movieBaseAppStore:MoviesAppBaseStoreProtocol = MoviesAppBaseStore()
    private let baseEndPointUrl = "\(Utils.BaseApiUrl)/movie/"
    
   
    func getMovieReviews(movieId: String) async throws -> [ReviewsModelResult] {
        
        guard let url = URL(string: "\(baseEndPointUrl)\(movieId)/reviews") else {  throw MoviesAppError.invalidEndPoints}
        do{
            let movieReviews: ReviewsModel =  try await movieBaseAppStore.loadURLAndDecode(url: url, params: nil)
            return movieReviews.results ?? []
        } catch{
            throw error
        }
    }
}
