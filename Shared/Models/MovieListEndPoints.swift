//
//  MovieListEndPoints.swift
//  MoviesApp
//
//  Created by Ahmed Ragab on 10/05/2022.
//

import Foundation

enum MovieListEndPoints:String,CaseIterable,Identifiable{
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    
    var description:String{
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
     
        }
    }
    
    var sortIndex: Int {
        switch self {
        case .nowPlaying:
            return 3
        case .upcoming:
            return 2
        case .topRated:
            return 1
        case .popular:
            return 0
        }
    }
    
    
    var systemImage: String {
        switch self {
        case .nowPlaying:
            return "timer"
        case .upcoming:
            return "calendar"
        case .popular:
            return "chart.line.uptrend.xyaxis"
        case .topRated:
            return "hands.clap"
        }
    }
}
