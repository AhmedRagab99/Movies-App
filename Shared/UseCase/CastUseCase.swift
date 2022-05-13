//
//  Casr.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 14/05/2022.
//

import Foundation
protocol CastUseCaseProtocol{
    func getCastForMovie(movieId:String) async throws -> [Cast]
}

class CastUseCase:CastUseCaseProtocol{
 
    let castRepo:CastRepoProtocol?
    init(castRepo:CastRepoProtocol) {
        self.castRepo = castRepo
    }
    
    func getCastForMovie(movieId: String) async throws -> [Cast] {
        if let castRepo = castRepo {
            do {
                let cast = try await castRepo.getCastForMovie(movieId: movieId)
                return cast
            } catch  {
                throw error
            }
        }
        return []
    }
    
}
