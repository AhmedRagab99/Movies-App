//
//  MovieSection.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import Foundation

struct MovieSection: Identifiable {
    
    let id = UUID()
    
    let movies: [Movie]
    let endpoint: MovieListEndPoints
    var title: String {
        endpoint.description
    }
}
