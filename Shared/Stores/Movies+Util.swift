//
//  MovieService.swift
//
//  Created by Ahmed Ragab on 08/05/2022.
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
            return 2
        case .upcoming:
            return 3
        case .topRated:
            return 1
        case .popular:
            return 0
        }
    }
    
    
    var systemImage: String {
        switch self {
        case .nowPlaying:
            return "newspaper"
        case .upcoming:
            return "building.2"
        case .topRated:
            return "desktopcomputer"
        case .popular:
            return "tv"
        }
    }
}

enum MoviesAppError:Error,CustomNSError{
    case apiError
    case invalidEndPoints
    case invalidResponse
    case noData
    case serializationError
    case geniricError
    
    var localizedDescriptipn:String{
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndPoints:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data"
        case .serializationError:
            return "Failed to decode data"
        case .geniricError:
            return "some thing went wrong"
        }
    }
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey:localizedDescriptipn]
    }
}
