//
//  CastRepo.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 14/05/2022.
//

import Foundation
protocol CastRepoProtocol{
    func getCastForMovie(movieId:String) async throws -> [Cast]
}

class CastRepo:CastRepoProtocol{
    private  var movieBaseAppStore:MoviesAppBaseStoreProtocol = MoviesAppBaseStore()
    
    private let baseEndPointUrl = "\(Utils.BaseApiUrl)/movie/"
    
    func getCastForMovie(movieId: String) async throws -> [Cast] {
        guard let url = URL(string: "\(baseEndPointUrl)\(movieId)/credits")
        
        else {  throw MoviesAppError.invalidEndPoints}
        do{
            let movieReviews: ActorModel =  try await movieBaseAppStore.loadURLAndDecode(url: url, params: nil)
            return movieReviews.cast ?? []
        } catch{
            throw error
        }
    }
}
