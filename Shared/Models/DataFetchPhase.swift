//
//  DataFetchPhase.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import Foundation
enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}

