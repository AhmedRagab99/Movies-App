//
//  CastViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 14/05/2022.
//

import Foundation
class CastViewModel:ObservableObject{
    @Published var castState:DataFetchPhase<[Cast]> = .empty
    private var castUseCase:CastUseCaseProtocol?
    
    init(castUseCase:CastUseCaseProtocol) {
        self.castUseCase = castUseCase
    }
    
    @MainActor func getMovieCast(movieId:String) async{
        if Task.isCancelled {return}
        castState = .empty
        if let castUseCase = castUseCase {
            do{
                if Task.isCancelled {return}
                let cast = try await  castUseCase.getCastForMovie(movieId: movieId)
                castState = .success(cast)
            }catch{
                if Task.isCancelled {return}
                castState  = .failure(error)
            }
        }
        
    }
}
